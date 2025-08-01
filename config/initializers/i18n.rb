# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]
I18n.available_locales = %i[en ja]
I18n.default_locale = :ja
I18n.fallbacks = %i[ja]
I18n.locale = ENV['LOCALE'].to_sym if ENV.key?('LOCALE')
