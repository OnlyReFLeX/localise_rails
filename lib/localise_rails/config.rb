module LocaliseRails
  # Class used to initialize configuration object.
  class Config
    attr_accessor :api_key, :options, :redis_options, :redis, :rename_locales, :prefix

    def initialize
      @options = {}
      @rename_locales = {}
      @redis_options = {}
      @prefix = nil
    end
  end
end
