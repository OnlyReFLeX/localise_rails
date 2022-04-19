module LocaliseRails
  class SeedTranslationsToRequestStore
    def call
      if fresh_data_in_memory?
        seed_translations_from_memory
      else
        seed_translations_from_cache
      end
    end

    private

    def seed_translations_from_memory
      RequestStore.store[:translations] = Thread.current[:translations]
    end

    def seed_translations_from_cache
      cached = LocaliseRails::FetchLocaliseCache.new.call
      return unless cached.data

      prepared_locales = prepare_locales(cached.data)
      prepared_locales.map { |locale, value| I18n.backend.store_translations(locale, value) }
      copy_request_store_to_memory(cached.timestamp)
    end

    def prepare_locales(locales)
      LocaliseRails.config.rename_locales.each do |old_key, new_key|
        locales[new_key] = locales.delete old_key
      end
      locales
    end

    def copy_request_store_to_memory(timestamp)
      Thread.current[:translations] = RequestStore.store[:translations]
      Thread.current[:translations_timestamp] = timestamp
    end

    def fresh_data_in_memory?
      Thread.current[:translations].present? && fresh_memory_data?
    end

    def fresh_memory_data?
      cached_timestamp.present? && memory_timestamp.present? && cached_timestamp == memory_timestamp
    end

    def cached_timestamp
      @cached_timestamp ||= LocaliseRails.config.redis.get(LocaliseRails::UPDATED_AT_CACHE_KEY)
    end

    def memory_timestamp
      @memory_timestamp ||= Thread.current[:translations_timestamp]
    end
  end
end
