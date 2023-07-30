# typed: strict
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

# ENV["PARALLEL_TEST_GROUPS"] = "true"

if ENV.fetch("TEST_COVERAGE", nil)
  require "simplecov"
  require "simplecov-cobertura"

  SimpleCov.formatter = if ENV.fetch("CI", nil)
                          SimpleCov::Formatter::CoberturaFormatter
                        else
                          SimpleCov::Formatter::HTMLFormatter
                        end
  SimpleCov.enable_coverage(:branch)
  SimpleCov.start("rails")
end

require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"
require "webmock/minitest"

require "test_helpers/mock"
require "test_helpers/text_message_helper"
require "test_helpers/term_helper"
require "test_helpers/notification_helper"
require "test_helpers/webpush_helper"

WebMock.disable_net_connect!(
  allow_localhost: true,
  # Used to download headless chrome in CI
  allow: "chromedriver.storage.googleapis.com",
)
Faker::Config.locale = "en-US"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include WebMock::API
    include TermHelper
    include TextMessageHelper
    include WebpushHelper
    include NotificationHelper

    parallelize(workers: :number_of_processors)
    parallelize_setup do |worker|
      SimpleCov.command_name("#{SimpleCov.command_name}-#{worker}") if ENV["TEST_COVERAGE"]

      Searchkick.index_suffix = worker

      # reindex models
      T.unsafe(Course).reindex
      T.unsafe(Instructor).reindex

      # and disable callbacks
      Searchkick.disable_callbacks
    end

    parallelize_teardown do |_worker|
      SimpleCov.result if ENV["TEST_COVERAGE"]
    end
  end
end

module ActionDispatch
  class IntegrationTest
    extend T::Sig
    include ActiveJob::TestHelper
    include Devise::Test::IntegrationHelpers
    include TermHelper
    include TextMessageHelper

    sig { void }
    def assert_redirected_to_login
      assert_response(:found)
      assert_redirected_to("/sign_in")
    end
  end
end
