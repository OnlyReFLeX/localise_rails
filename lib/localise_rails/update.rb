module LocaliseRails
  class Update
    class << self
      def call
        headers = { Authorization: "Loco #{LocaliseRails.config.api_key}", Accept: 'application/json' }
        query = LocaliseRails.config.options.map { |k, v| "#{k}=#{v}" }.join('&')
        uri = "https://localise.biz/api/export/all?#{query}"

        LocaliseRails.logger.info('LocaliseRails: start getting locales from localise')
        response = HTTParty.get(uri, headers: headers)

        if response.success?
          LocaliseRails.logger.info('LocaliseRails: locales got successfully')
          LocaliseRails.config.redis.set(LocaliseRails::DATA_CACHE_KEY, response.parsed_response.to_json)
          LocaliseRails.config.redis.set(LocaliseRails::UPDATED_AT_CACHE_KEY, Time.current.to_i)
        else
          LocaliseRails.logger.error "LocaliseRails: Something went wrong downloading translations: #{response.parsed_response}"
        end
      rescue StandardError => e
        LocaliseRails.logger.error("LocaliseRails: #{e.message}")
        LocaliseRails.logger.error(e.backtrace.join("\n"))
      end
    end
  end
end
