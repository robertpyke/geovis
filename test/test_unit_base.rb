require 'test/unit'
require 'geovis'

module GeoVis
  module Tests
    class TestUnitBase < Test::Unit::TestCase

      # Use the RGEO active record adapter test helper

      def test_should_pass
        assert(true)
      end

      def test_should_not_be_able_to_init
        assert_raise do
          my_instance = GeoVis::Base.new()
        end
      end

    end
  end
end
