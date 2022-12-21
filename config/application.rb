# typed: false
# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HotseatIo
  class Application < Rails::Application
    config.load_defaults(6.1)

    config.exceptions_app = routes

    config.active_record.schema_format = :sql

    # Async is a fine ActiveJob adapter while our only job is the Slack notifier, but
    # we'll probably want something more robust if we add other jobs.
    # https://api.rubyonrails.org/classes/ActiveJob/QueueAdapters/AsyncAdapter.html
    config.active_job.queue_adapter = :async

    config.generators do |g|
      g.scaffold_stylesheet(false)
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

require "debug/open_nonstop" if defined?(Rails::Server) && Rails.env.development?
