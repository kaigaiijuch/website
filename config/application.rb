# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Website
  class Application < Rails::Application # rubocop: disable Style/Documentation
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

    # Default URL Options in Ruby on Rails - Team Qameta https://qameta.com/posts/default-url-options-in-ruby-on-rails/
    url_options = {
      host: ENV.fetch('WEBSITE_HOST', nil),
      protocol: ENV.fetch('WEBSITE_PROTOCOL', nil)
    }
    # TODO: it does not work well with root_url in url_helpers
    Rails.application.routes.default_url_options = url_options
    Rails.application.default_url_options = url_options
  end
end
