# typed: strict
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'
require 'webmock/minitest'
WebMock.disable_net_connect!(
  allow_localhost: true,
  # Used to download headless chrome in CI
  allow: 'chromedriver.storage.googleapis.com',
)

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include WebMock::API

    parallelize(workers: :number_of_processors)
  end
end
