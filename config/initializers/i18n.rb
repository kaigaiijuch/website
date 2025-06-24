# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]
I18n.available_locales = %i[en ja]
I18n.default_locale = :en
I18n.fallbacks = %i[ja]
