module LocaliseRails
  # Class used to initialize configuration object.
  class Config
    attr_accessor :api_key, :options, :redis_options, :rename_locales

    def initialize
      @options = {}
      @rename_locales = {}
      @redis_options = {}
    end
  end
end
