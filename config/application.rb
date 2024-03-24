# frozen_string_literal: true

require_relative 'boot'

# require 'rails/all' # This is for full rails
require 'rails'
require 'active_model/railtie'
# require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Website
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.x.website_title.base = ENV.fetch('WEBSITE_TITLE_BASE', nil)
    config.x.website_title.separator = ENV.fetch('WEBSITE_TITLE_SEPARATOR', nil)
    config.x.google_tag_manager_id = ENV.fetch('GOOGLE_TAG_MANAGER_ID', nil)
    config.x.feedback_google_form_id = ENV.fetch('FEEDBACK_GOOGLE_FORM_ID', nil)

    # Default URL Options in Ruby on Rails - Team Qameta https://qameta.com/posts/default-url-options-in-ruby-on-rails/
    config.x.website_uri = URI.parse(ENV.fetch('WEBSITE_URI', ''))
    url_options = {
      host: config.x.website_uri.host,
      protocol: config.x.website_uri.scheme
    }
    # TODO: it does not work well with root_url in url_helpers
    Rails.application.routes.default_url_options = url_options
    Rails.application.default_url_options = url_options
  end
end
