module GeoVis
  module BoundAndClustered

    # The smallest grid size for which clustering is enabled.
    # Below this value, grid size is set to nil (no clustering).
    MIN_GRID_SIZE_BEFORE_NO_CLUSTERING = 0.01

    # The grid size is the span of window divided by GRID_SIZE_WINDOW_FRACTION
    GRID_SIZE_WINDOW_FRACTION = 40

    def BoundAndClustered.calc_cluster_grid_size(bbox=nil)
      return nil if bbox.nil?

      GeoVis.logger.debug("Calculating grid size for bbox: #{bbox.inspect}")

      bbox_f = bbox.map { |el| el.to_f }
      w, s, e, n = *bbox

      horizontal_range = e - w
      vertical_range   = n - s

      GeoVis.logger.debug("Horizontal Range: #{horizontal_range.inspect}")
      GeoVis.logger.debug("Vertical Range: #{vertical_range.inspect}")

      range_avg = (horizontal_range + vertical_range) / 2
      range_avg = range_avg.abs

      GeoVis.logger.debug("Avg Range: #{range_avg.inspect}")

      grid_size = ( range_avg / GRID_SIZE_WINDOW_FRACTION.to_f ).round(3)

      GeoVis.logger.debug("Calculated Grid Size: #{grid_size.inspect}")

      grid_size = nil if grid_size < MIN_GRID_SIZE_BEFORE_NO_CLUSTERING

      GeoVis.logger.debug("Returning Grid Size: #{grid_size.inspect}")

      grid_size
    end

    # The clustering technique outputs features as clusters.
    #
    # Params:
    #
    # +relation+::  is an ActiveRecord::Relation.
    #               The relation must have a geometry attribute.
    #
    # +bbox::       An Array of floats, [w, s, e, n]. Used to determine the
    #               grid_size if not specified.
    #
    # +grid_size+:: A float representing the grid size. If nil, will
    #               automatically calculate grid size from +bbox+.

    def features(relation, bbox, grid_size=nil)
      features = []

      grid_size = GeoVis::BoundAndClustered::calc_cluster_grid_size(bbox)

      bound_result = GeoVis::Bound.in_rect(relation, bbox)
      bound_and_clustered_result  = GeoVis::Clustered.cluster(bound_result, grid_size)

      bound_and_clustered_result.each do |cluster|
        geom_feature = relation.rgeo_factory_for_column(:geometry).parse_wkt(cluster.cluster_centroid)
        feature = RGeo::GeoJSON::Feature.new(geom_feature, nil, { cluster_size: cluster.cluster_geometry_count.to_i })

        features << feature
      end

      features
    end

  end
end
