# typed: strict
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

if ENV.fetch("TEST_COVERAGE", nil)
  require "simplecov"
  require "simplecov-cobertura"

  SimpleCov.formatter = if ENV.fetch("CI", nil)
                          SimpleCov::Formatter::CoberturaFormatter
                        else
                          SimpleCov::Formatter::HTMLFormatter
                        end
  SimpleCov.start("rails")
end

require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"
require "webmock/minitest"
WebMock.disable_net_connect!(
  allow_localhost: true,
  # Used to download headless chrome in CI
  allow: "chromedriver.storage.googleapis.com",
)

module TermHelper
  extend T::Sig
  include FactoryBot::Syntax::Methods
  include ActiveSupport::Testing::TimeHelpers

  sig { returns(Term) }
  def create_current_term
    term = create(:term, term: "21S",
                         start_date: Date.new(2021, 3, 29),
                         end_date: Date.new(2021, 6, 11))
    travel_to(Time.zone.local(2021, 5, 14))
    term
  end
end

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include WebMock::API
    include TermHelper

    parallelize(workers: :number_of_processors)
    parallelize_setup do |worker|
      Searchkick.index_suffix = worker

      # reindex models
      T.unsafe(Course).reindex
      T.unsafe(Instructor).reindex

      # and disable callbacks
      Searchkick.disable_callbacks
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
    include TermHelper
  end
end

SimpleCov.command_name("features #{Process.pid}") if ENV.fetch("TEST_COVERAGE", nil)
