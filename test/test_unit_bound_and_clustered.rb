require 'test/unit'
require 'geovis'

module GeoVis
  module Tests
    class TestUnitBoundAndClustered < Test::Unit::TestCase

      # Use the RGEO active record adapter test helper

      def test_should_pass
        assert(true)
      end

      def test_should_calc_grid_size
        w = -25
        s = -20
        e = 20
        n = 30

        bbox=[w,s,e,n]

        grid_size = BoundAndClustered.calc_cluster_grid_size(bbox)
        assert(grid_size.is_a?(Numeric), "Expected grid_size to be a Numeric. It was: #{grid_size.inspect}")
        assert(grid_size > 0)
      end

    end
  end
end
