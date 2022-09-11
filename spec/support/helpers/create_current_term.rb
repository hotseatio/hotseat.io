# typed: false
# frozen_string_literal: true

module Helpers
  include ActiveSupport::Testing::TimeHelpers

  # Create a term and travel to that term
  def create_current_term
    term = create :term, term: '21S',
                         start_date: Date.new(2021, 3, 29),
                         end_date: Date.new(2021, 6, 11)
    travel_to Time.zone.local(2021, 5, 14)
    term
  end
end
