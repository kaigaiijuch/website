# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'active_hash' # for static data
gem 'bootsnap', require: false
gem 'meta-tags' # for SEO and social media meta tags
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'rails_autolink' # for linking URLs
gem 'scenic' # for database views
gem 'scenic_sqlite_adapter' # for database views sqlite support
gem 'sitemap_generator' # for sitemap.xml
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'bullet' # for N+1 queries
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails' # for environment variables
  gem 'rubocop-rails', require: false # for code linting
end

group :development do
  gem 'annotate' # for model annotations
  gem 'rack-mini-profiler'
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem 'capybara'
  # gem 'selenium-webdriver'
  gem 'webmock', require: false # for mocking HTTP requests
end
