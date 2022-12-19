# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.1'

# dotenv has to come first so other gems can use the env vars
# https://github.com/bkeepers/dotenv
gem 'dotenv-rails', groups: %i[development test]

gem 'rails', '~> 7.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# Handle malicious requests
gem 'rack-attack'

# Frontend components
gem 'cssbundling-rails'
gem 'jsbundling-rails'
gem 'propshaft'
gem 'turbo-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Postgres as database
gem 'pg'
# Sorbet
gem 'sorbet-rails'
gem 'sorbet-runtime'

# Pagination
gem 'kaminari'

# Logins
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

# Search
gem 'searchjoy'
gem 'searchkick'
# Search dependencies
gem 'faraday_middleware-aws-sigv4'
gem 'oj'
gem 'opensearch-ruby'
gem 'typhoeus'

# Sitemap
gem 'aws-sdk-s3'
gem 'sitemap_generator'

# Analytics
gem 'ahoy_matey'
gem 'blazer'

# Useful for textbooks
gem 'lisbn'

# Useful for phone numbers
gem 'phonelib'

# Logging
gem 'lograge'
gem 'lograge-sql'

# Static pages
gem 'high_voltage'
gem 'redcarpet'

# Payments
gem 'pay', '~> 3.0'
gem 'stripe', '>= 2.8', '< 6.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# rake scrape
gem 'aws-sdk-lambda'
gem 'httparty'
gem 'nokogiri'
gem 'pdf-reader'

gem 'mini_portile2' # needed for Tapioca for some reason

# Metrics
gem 'ddtrace'

# Phone verification
gem 'twilio-ruby'

# Add users to Mailchimp list
gem 'MailchimpMarketing'

# Gibberish detection
gem 'gibberish_detector'

# Sentry
gem 'sentry-rails'
gem 'sentry-ruby'

group :development, :test do
  gem 'debug', '>= 1.0.0'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Rubocop
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-sorbet', require: false
  # ERB Linting
  gem 'erb_lint', require: false
  # Sorbet
  gem 'sorbet'
  gem 'tapioca', require: false
  # Diagrams
  gem 'rails-erd'
  # Pry
  gem 'pry'
  gem 'pry-rails'
  # Mail
  gem 'letter_opener'
end

group :test do
  gem 'minitest-spec-rails'
  # Mocking
  gem 'mocha'
  # Stub ENV
  gem 'climate_control'
  # Fake values
  gem 'faker'
  # Cuprite browser driver
  gem 'cuprite'
  # Mock web requests
  gem 'webmock'
  # Code coverage
  gem 'simplecov'
end
