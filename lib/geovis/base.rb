module GeoVis

  module Base

    def analyse_features
      start_t = Time.now
      end_t = Time.now
      the_features = features()
      took_t = end_t - start_t

      the_features

      GeoVis.logger.info("Time took to get features: #{took_t}s")
    end

    def get_features(options)
      features(options)
    end

    def features
      raise NotImplementedError, "features is not yet implemented for this class"
    end

  end

end
