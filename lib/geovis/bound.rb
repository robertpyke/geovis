module GeoVis
  module Bound
    include Base

    def Bound.in_rect(relation, bbox)
      bbox_f = bbox.map { |el| el.to_f }
      w, s, e, n = *bbox_f

      sw = relation.rgeo_factory_for_column(:geometry).point(w, s)
      ne = relation.rgeo_factory_for_column(:geometry).point(e, n)

      box = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne)
      mappable_relation = relation.where{geometry.op('&&', box)}
    end

    # The Basic visualisation technique simply outputs all features that
    # it finds.
    #
    # +relation+:: is an ActiveRecord::Relation.
    #              The relation must have a geometry attribute.
    #
    # +bbox::      An Array of floats, [w, s, e, n].

    def features(relation, bbox)
      features = []

      mappable_relation = Bound.in_rect(relation, bbox)

      GeoVis::Basic.features(mappable_relation)
    end

  end
end
