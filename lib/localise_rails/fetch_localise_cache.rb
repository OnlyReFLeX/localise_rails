module LocaliseRails
  class FetchLocaliseCache
    def call
      CachedTranslations.new(fetch_translations)
    end

    private

    def fetch_translations
      LocaliseRails.logger.info('Localise: start getting locales from redis')
      {
        data: JSON.parse(LocaliseRails.config.redis.get(DATA_CACHE_KEY)),
        timestamp: LocaliseRails.config.redis.get(UPDATED_AT_CACHE_KEY)
      }
    end

    class CachedTranslations
      include ActiveModel::Model
      attr_accessor :data, :timestamp
    end
  end
end
