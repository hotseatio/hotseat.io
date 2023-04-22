# typed: strict
# frozen_string_literal: true

require "lograge/sql/extension"

Rails.application.configure do
  # Lograge config
  config.lograge.enabled = true
  config.colorize_logging = true

  config.lograge.custom_options = lambda do |event|
    { params: event.payload[:params],
      level: event.payload[:level] }
  end
end
