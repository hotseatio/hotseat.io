# typed: strict
# frozen_string_literal: true

require 'test_helper'

class TermHelperTest < ActionView::TestCase
  include TermHelper

  describe 'term_badge_color' do
    it 'returns green if the term is upcoming' do
      spring = create(:term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11))
      summer = create(:term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10))
      fall = create(:term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14))
      travel_to Time.zone.local(2021, 6, 14)

      assert_equal(ColorHelper::Color::Green, term_badge_color(summer, spring, [summer, fall]))
    end

    it 'returns green if the term is current and before/during week 4' do
      spring = create(:term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11))
      summer = create(:term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10))
      fall = create(:term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14))
      travel_to Time.zone.local(2021, 4, 14)

      assert_equal(ColorHelper::Color::Green, term_badge_color(spring, spring, [summer, fall]))
    end

    it 'returns yellow if the term is current and after week 4' do
      spring = create(:term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11))
      summer = create(:term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10))
      fall = create(:term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14))
      travel_to Time.zone.local(2021, 6, 14)

      assert_equal(ColorHelper::Color::Yellow, term_badge_color(spring, spring, [summer, fall]))
    end

    it 'returns gray if the term is not current or upcoming' do
      winter = create(:term, term: '21W',
                             start_date: Date.new(2021, 1, 4),
                             end_date: Date.new(2021, 3, 19))
      spring = create(:term, term: '21S',
                             start_date: Date.new(2021, 3, 29),
                             end_date: Date.new(2021, 6, 11))
      summer = create(:term, term: '211',
                             start_date: Date.new(2021, 6, 21),
                             end_date: Date.new(2021, 9, 10))
      fall = create(:term, term: '21F',
                           start_date: Date.new(2021, 9, 21),
                           end_date: Date.new(2021, 12, 14))
      travel_to Time.zone.local(2021, 6, 14)

      assert_equal(ColorHelper::Color::Gray, term_badge_color(winter, spring, [summer, fall]))
    end
  end
end
