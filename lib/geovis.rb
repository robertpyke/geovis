require "geovis/version"
require "geovis/base"
require "geovis/basic"
require "geovis/bound"
require "geovis/clustered"
require "geovis/bound_and_clustered"

require "logger"

module GeoVis

  @@logger       = Logger.new(STDOUT)
  @@logger.level = Logger::DEBUG

  def GeoVis.logger
    @@logger
  end

  def GeoVis.logger=(new_logger)
    @@logger = new_logger
  end

end
