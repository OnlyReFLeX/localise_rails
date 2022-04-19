module LocaliseRails
  class FetchLocaliseCache
    def call
      CachedTranslations.new(fetch_translations)
    end

    private

    def fetch_translations
      LocaliseRails.logger.info('Localise: start getting locales from redis')
      timestamp = LocaliseRails.config.redis.get(UPDATED_AT_CACHE_KEY)
      if timestamp.present?
        data = LocaliseRails.config.redis.get(DATA_CACHE_KEY)
        {
          data: JSON.parse(data),
          timestamp: timestamp
        }
      else
        {}
      end
    end

    class CachedTranslations
      include ActiveModel::Model
      attr_accessor :data, :timestamp
    end
  end
end
