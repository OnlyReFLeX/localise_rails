module LocaliseRails
  class RequestStoreTranslations
    def [](key)
      seed_translations if RequestStore.store[:translations].nil?
      RequestStore.store.dig(:translations, key)
    end

    def []=(key, value)
      RequestStore.store[:translations][key] = value
    end

    def keys
      seed_translations if RequestStore.store[:translations].nil?
      RequestStore.store[:translations].keys
    end

    private

    def seed_translations
      RequestStore.store[:translations] = {}
      LocaliseRails::SeedTranslationsToRequestStore.new.call
    end
  end
end
