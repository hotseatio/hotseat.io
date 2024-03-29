# typed: strict
# frozen_string_literal: true

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
