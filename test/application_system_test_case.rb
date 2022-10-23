# typed: strict
# frozen_string_literal: true

require 'test_helper'
require 'capybara/cuprite'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include FactoryBot::Syntax::Methods
  include Capybara::DSL
  include Devise::Test::IntegrationHelpers
  include TermHelper

  driven_by :cuprite
end
