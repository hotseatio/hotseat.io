# typed: strict
# frozen_string_literal: true

require 'test_helper'
require 'capybara/cuprite'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include FactoryBot::Syntax::Methods
  include Capybara::DSL
  include Devise::Test::IntegrationHelpers

  driven_by :cuprite

  sig { returns(Term) }
  def create_current_term
    term = create :term, term: '21S',
                         start_date: Date.new(2021, 3, 29),
                         end_date: Date.new(2021, 6, 11)
    travel_to Time.zone.local(2021, 5, 14)
    term
  end
end
