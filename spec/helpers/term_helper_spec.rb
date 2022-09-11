# typed: false
# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TermHelper. For example:
#
# describe TermHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TermHelper, type: :helper do
  describe 'term_badge_color' do
    it 'returns green if the term is upcoming' do
      spring = create :term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11)
      summer = create :term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10)
      fall = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14)
      travel_to Time.zone.local(2021, 6, 14)

      expect(helper.term_badge_color(summer, spring, [summer, fall])).to eq(ColorHelper::Color::Green)
    end

    it 'returns green if the term is current and before/during week 4' do
      spring = create :term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11)
      summer = create :term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10)
      fall = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14)
      travel_to Time.zone.local(2021, 4, 14)

      expect(helper.term_badge_color(spring, spring, [summer, fall])).to eq(ColorHelper::Color::Green)
    end

    it 'returns yellow if the term is current and after week 4' do
      spring = create :term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11)
      summer = create :term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10)
      fall = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14)
      travel_to Time.zone.local(2021, 6, 14)

      expect(helper.term_badge_color(spring, spring, [summer, fall])).to eq(ColorHelper::Color::Yellow)
    end

    it 'returns gray if the term is not current or upcoming' do
      winter = create :term, term: '21W',
                             start_date: Date.new(2021, 1, 4),
                             end_date: Date.new(2021, 3, 19)
      spring = create :term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11)
      summer = create :term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10)
      fall = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14)
      travel_to Time.zone.local(2021, 6, 14)

      expect(helper.term_badge_color(winter, spring, [summer, fall])).to eq(ColorHelper::Color::Gray)
    end
  end
end
