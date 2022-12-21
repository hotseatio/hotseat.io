# typed: strict
# frozen_string_literal: true

require "ddtrace"

unless T.unsafe(Rails.env).development? || T.unsafe(Rails.env).test?
  Datadog.configure do |c|
    c.tracing.instrument(:rails, service_name: "hotseat-rails")
  end
end
