module GeoVis
  module Clustered

    include Base

    # Clusters the relation, returning:
    #
    # +cluster_geometry_count+:: the size of the cluster.
    #
    # +cluster_centroid+:: the centroid of the cluster.
    #
    # Params:
    #
    # +relation+:: is an ActiveRecord::Relation.
    #              The relation must have a geometry attribute.
    #
    # +grid_size+:: A float representing the grid size. If nil, will 
    #               perform a GroupBy, effectively clustering exact matches.

    def Clustered::cluster(relation, grid_size)

      if grid_size.nil?
        relation.
          select{count(geometry).as("cluster_geometry_count")}.
          select{st_astext(geometry).as("cluster_centroid")}.
          group{geometry}
      else
        relation.
          select{count(geometry).as("cluster_geometry_count")}.
          select{st_astext(st_centroid(st_collect(geometry))).as("cluster_centroid")}.
          group{st_snaptogrid(geometry, grid_size)}
      end

    end

    # The clustering technique outputs features as clusters.
    #
    # Params:
    #
    # +relation+:: is an ActiveRecord::Relation.
    #              The relation must have a geometry attribute.
    #
    # +grid_size+:: A float representing the grid size. If nil, will 
    #               perform a GroupBy, effectively clustering exact matches.

    def features(relation, grid_size)
      features = []

      cluster_result = GeoVis::Clustered.cluster(relation, grid_size)

      cluster_result.each do |cluster|
        geom_feature = Mappable.rgeo_factory_for_column(:geometry).parse_wkt(cluster.cluster_centroid)
        feature = RGeo::GeoJSON::Feature.new(geom_feature, nil, { cluster_size: cluster.cluster_geometry_count.to_i })

        features << feature
      end

      features
    end

  end
end
