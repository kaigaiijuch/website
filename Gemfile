# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'active_hash'
gem 'bootsnap', require: false
gem 'puma', '>= 5.0'
gem 'rails', github: 'rails/rails', branch: 'main' # edge rails
gem 'sitemap_generator'
gem 'sprockets-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'rack-mini-profiler'
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem 'capybara'
  # gem 'selenium-webdriver'
  gem 'webmock', require: false
end
