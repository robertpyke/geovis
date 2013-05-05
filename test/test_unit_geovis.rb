require 'test/unit'
require 'geovis'

module GeoVis
  module Tests
    class TestUnitGeoVis < Test::Unit::TestCase

      # Use the RGEO active record adapter test helper

      def test_should_pass
        assert(true)
      end

      def test_should_have_a_version
        assert_not_nil(GeoVis::VERSION)
      end

      def test_should_be_able_to_access_logger
        assert_not_nil(GeoVis.logger)
      end

    end
  end
end
