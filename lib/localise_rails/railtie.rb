require 'rails'
require 'i18n'

module LocaliseRails
  class Railtie < ::Rails::Railtie
    initializer 'localise_rails.setup_logging' do
      LocaliseRails.logger = Rails.logger
    end

    config.i18n.backend = I18n::Backend::Chain.new(
      I18n::Backend::KeyValue.new(LocaliseRails::RequestStoreTranslations.new),
      I18n.backend
    )
  end
end
