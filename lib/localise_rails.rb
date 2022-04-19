# requires
require 'localise_rails/version'
require 'localise_rails/logger'
require 'localise_rails/config'
require 'localise_rails/update'
require 'localise_rails/seed_translations_to_request_store'
require 'localise_rails/request_store_translations'
require 'localise_rails/fetch_localise_cache'

# gems
require 'redis'
require 'request_store'

module LocaliseRails
  extend ActiveSupport::Autoload

  DATA_CACHE_KEY = 'localise/data'.freeze
  UPDATED_AT_CACHE_KEY = 'localise/updated_at'.freeze

  def self.update
    LocaliseRails::Update.call
  end

  def self.config
    @config ||= LocaliseRails::Config.new
  end

  # Lets you set global configuration options.
  #
  # All available options and their defaults are in the example below:
  # @example Initializer for Rails
  # LocaliseRails.configure do |config|
  #   config.api_key = "LOCALISE_KEY"
  #
  #   # all options https://localise.biz/api/docs/export/exportall
  #   config.options = {
  #     filter: 'backend',
  #     fallback: 'en-US'
  #   }
  #
  #   config.rename_locales = {
  #     'en-US' => 'en'
  #   }
  #
  #   # all options https://github.com/redis/redis-rb
  #   # config.redis_options = {
  #   #   host: "127.0.0.1",
  #   #   port: 6379,
  #   #   db: 1,
  #   #   url: "redis://:p4ssw0rd@127.0.0.1:6379/1"
  #   # }
  # end
  def self.configure
    yield(config) if block_given?
    config.redis = Redis.new(config.redis_options)
  end
end

require 'localise_rails/railtie' if defined?(Rails)
