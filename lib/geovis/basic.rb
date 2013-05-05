module GeoVis
  module Basic

    # The Basic visualisation technique simply outputs all features that
    # it finds.
    #
    # +relation+ is an ActiveRecord::Relation.
    #
    # The relation must have a geometry attribute.
    def features(relation)

      features = []
      mappable_relation = relation

      mappable_relation.each do |mappable|
        geom_feature = mappable.geometry
        feature = RGeo::GeoJSON::Feature.new(geom_feature, mappable.id, { cluster_size: 1 })
        features << feature
      end

      features
    end

  end
end
