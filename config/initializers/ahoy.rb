# typed: strict
# frozen_string_literal: true

module Ahoy
  class Store < Ahoy::DatabaseStore
  end
end

# set to true for JavaScript tracking
# We set this false because we use a custom path
# https://github.com/ankane/ahoy/issues/431
# Ahoy.api = true

# Track visits on client-side, preventing bots and users
# with cookies disabled
# https://github.com/ankane/ahoy#visits
Ahoy.server_side_visits = :when_needed
