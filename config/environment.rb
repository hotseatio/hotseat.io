# typed: strict
# frozen_string_literal: true

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
Jbuilder.deep_format_keys(true)
