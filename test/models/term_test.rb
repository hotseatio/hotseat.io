# typed: strict
# frozen_string_literal: true

require 'test_helper'

class TermTest < ActiveSupport::TestCase
  ALL_TERMS = T.let([
    'Winter 1999',
    'Spring 1999',
    'Summer 1999',
    'Fall 1999',
    'Winter 2000',
    'Spring 2000',
    'Summer 2000',
    'Fall 2000',
    'Winter 2001',
    'Spring 2001',
    'Summer 2001',
    'Fall 2001',
    'Winter 2002',
    'Spring 2002',
    'Summer 2002',
    'Fall 2002',
    'Winter 2003',
    'Spring 2003',
    'Summer 2003',
    'Fall 2003',
    'Winter 2004',
    'Spring 2004',
    'Summer 2004',
    'Fall 2004',
    'Winter 2005',
    'Spring 2005',
    'Summer 2005',
    'Fall 2005',
    'Winter 2006',
    'Spring 2006',
    'Summer 2006',
    'Fall 2006',
    'Winter 2007',
    'Spring 2007',
    'Summer 2007',
    'Fall 2007',
    'Winter 2008',
    'Spring 2008',
    'Summer 2008',
    'Fall 2008',
    'Winter 2009',
    'Spring 2009',
    'Summer 2009',
    'Fall 2009',
    'Winter 2010',
    'Spring 2010',
    'Summer 2010',
    'Fall 2010',
    'Winter 2011',
    'Spring 2011',
    'Summer 2011',
    'Fall 2011',
    'Winter 2012',
    'Spring 2012',
    'Summer 2012',
    'Fall 2012',
    'Winter 2013',
    'Spring 2013',
    'Summer 2013',
    'Fall 2013',
    'Winter 2014',
    'Spring 2014',
    'Summer 2014',
    'Fall 2014',
    'Winter 2015',
    'Spring 2015',
    'Summer 2015',
    'Fall 2015',
    'Winter 2016',
    'Spring 2016',
    'Summer 2016',
    'Fall 2016',
    'Winter 2017',
    'Spring 2017',
    'Summer 2017',
    'Fall 2017',
    'Winter 2018',
    'Spring 2018',
    'Summer 2018',
    'Fall 2018',
    'Winter 2019',
    'Spring 2019',
    'Summer 2019',
    'Fall 2019',
    'Winter 2020',
    'Spring 2020',
    'Summer 2020',
    'Fall 2020',
    'Winter 2021',
    'Spring 2021',
    'Summer 2021',
    'Fall 2021',
    'Winter 2022',
    'Spring 2022',
    'Summer 2022',
    'Fall 2022',
    'Winter 2023',
    'Spring 2023',
    'Summer 2023',
    'Fall 2023',
    'Winter 2024',
    'Spring 2024',
    'Summer 2024',
    'Fall 2024',
    'Winter 2025',
    'Spring 2025',
    'Summer 2025',
    'Fall 2025',
    'Winter 2026',
    'Spring 2026',
    'Summer 2026',
    'Fall 2026',
    'Winter 2027',
    'Spring 2027',
    'Summer 2027',
    'Fall 2027',
  ].freeze, T::Array[String])

  it 'has an enrollment start time' do
    start_time = Time.zone.now
    term = create :term
    create(:enrollment_appointment,
           term:,
           pass: 'priority',
           first: start_time,
           last: start_time + 3.days)

    assert_in_delta start_time, term.enrollment_start, 1
  end

  it 'has an enrollment end time' do
    end_time = Time.zone.now
    term = create :term
    create(:enrollment_appointment,
           term:,
           pass: 'second',
           standing: 'freshman',
           first: end_time - 3.days,
           last: end_time)

    assert_in_delta((end_time + 10.days).at_end_of_day, term.enrollment_end, 1)
  end

  it 'returns a hash of enrollment pass start times' do
    term = create :term
    priority_start_time = Time.zone.now
    first_pass_start_time = priority_start_time + 4.days
    second_pass_start_time = first_pass_start_time + 1.week
    create(:enrollment_appointment,
           term:,
           pass: 'priority',
           first: priority_start_time,
           last: priority_start_time + 3.days)
    create(:enrollment_appointment,
           term:,
           pass: 'first',
           first: first_pass_start_time,
           last: first_pass_start_time + 1.day)
    create(:enrollment_appointment,
           term:,
           pass: 'second',
           first: second_pass_start_time,
           last: second_pass_start_time + 1.day)

    assert_in_delta(priority_start_time, term.enrollment_period_markers[0].time)
    assert_equal('Priority pass', term.enrollment_period_markers[0].label)
    assert_in_delta(first_pass_start_time, term.enrollment_period_markers[1].time)
    assert_equal('First pass', term.enrollment_period_markers[1].label)
    assert_in_delta(second_pass_start_time, term.enrollment_period_markers[2].time)
    assert_equal('Second pass', term.enrollment_period_markers[2].label)
  end

  describe 'current' do
    it 'returns the latest term' do
      create :term, term: '21W',
                    start_date: Date.new(2021, 1, 4),
                    end_date: Date.new(2021, 3, 19)
      create :term, term: '21S',
                    start_date: Date.new(2021, 3, 29),
                    end_date: Date.new(2021, 6, 11)
      create :term, term: '211',
                    start_date: Date.new(2021, 6, 21),
                    end_date: Date.new(2021, 9, 10)
      travel_to Time.zone.local(2021, 6, 14)
      assert_equal('21S', Term.current.term)
    end
  end

  it 'can order terms chronologically ascending' do
    Rails.application.load_seed
    terms = Term.all.order_chronologically_asc.map(&:readable)
    assert_equal(ALL_TERMS, terms)
  end

  it 'can order terms chronologically descending' do
    Rails.application.load_seed
    terms = Term.all.order_chronologically_desc.map(&:readable)
    assert_equal(ALL_TERMS.reverse, terms)
  end

  describe 'Comparison operations' do
    it 'can determine if one term is less than another' do
      term1 = build :term, term: '18F'
      term2 = build :term, term: '19S'
      assert_operator term1, :<, term2
    end

    it 'can determine if one term is greater than another' do
      term1 = build :term, term: '181'
      term2 = build :term, term: '18W'
      assert_operator term1, :>, term2
    end
  end

  describe 'current_week' do
    it 'Gives the current week' do
      term = build :term, term: '19S',
                          start_date: Date.new(2021, 3, 29),
                          end_date: Date.new(2021, 6, 11)
      travel_to Time.zone.local(2021, 4, 20)
      assert_equal(4, term.current_week)
    end

    it 'returns nil if the date is before the start date' do
      term = build :term, term: '19S',
                          start_date: Date.new(2021, 3, 29),
                          end_date: Date.new(2021, 6, 11)
      travel_to Time.zone.local(2021, 2, 20)
      assert_nil(term.current_week)
    end

    it 'returns a number if the date is after the end date' do
      term = build :term, term: '19S',
                          start_date: Date.new(2021, 3, 29),
                          end_date: Date.new(2021, 6, 11)
      travel_to Time.zone.local(2021, 7, 20)
      assert_equal(17, term.current_week)
    end

    it 'returns nil if there is no start date' do
      term = build :term, term: '19S'
      travel_to Time.zone.local(2021, 7, 20)
      assert_nil(term.current_week)
    end

    it 'returns 11 for finals week' do
      term = build :term, term: '19S',
                          start_date: Date.new(2021, 3, 29),
                          end_date: Date.new(2021, 6, 11)
      travel_to Time.zone.local(2021, 6, 11)
      assert_equal(11, term.current_week)
    end

    it 'returns 0 if there is a zero week' do
      term = build :term, term: '20F',
                          start_date: Date.new(2020, 10, 1),
                          end_date: Date.new(2020, 12, 18)
      travel_to Time.zone.local(2020, 10, 2)
      assert_equal(0, term.current_week)
    end
  end

  describe 'current_week_label' do
    it 'Gives the current week' do
      term = build :term, term: '19S',
                          start_date: Date.new(2021, 3, 29),
                          end_date: Date.new(2021, 6, 11)
      travel_to Time.zone.local(2021, 4, 20)
      assert_equal('Week 4', term.current_week_label)
    end

    it 'Can handle terms with a zero week' do
      term = build :term, term: '20F',
                          start_date: Date.new(2020, 10, 1),
                          end_date: Date.new(2020, 12, 18)
      travel_to Time.zone.local(2020, 10, 2)
      assert_equal('Week 0', term.current_week_label)
    end

    it 'Can handle finals week' do
      term = build :term, term: '20F',
                          start_date: Date.new(2020, 10, 1),
                          end_date: Date.new(2020, 12, 18)
      travel_to Time.zone.local(2020, 12, 18)
      assert_equal('Finals Week', term.current_week_label)
    end

    it 'Returns nil if the term does not have a start date' do
      term = build :term, term: '20F'
      travel_to Time.zone.local(2020, 10, 2)
      assert_nil(term.current_week_label)
    end

    it 'Returns nil if the date is before the start date' do
      term = build :term, term: '20F',
                          start_date: Date.new(2020, 10, 1),
                          end_date: Date.new(2020, 12, 18)
      travel_to Time.zone.local(2020, 9, 29)
      assert_nil(term.current_week_label)
    end

    it 'Returns nil for summer terms' do
      term = build :term, term: '201',
                          start_date: Date.new(2020, 6, 22),
                          end_date: Date.new(2020, 9, 11)
      travel_to Time.zone.local(2020, 7, 4)
      assert_nil(term.current_week_label)
    end
  end

  describe 'live_enrollment?' do
    it 'returns true if the current date is during the enrollment times' do
      term = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 23),
                           end_date: Date.new(2021, 12, 22)
      create(:enrollment_appointment, pass: 'priority',
                                      first: Date.new(2021, 6, 14),
                                      last: Date.new(2021, 6, 16),
                                      term:)
      create(:enrollment_appointment, pass: 'second',
                                      standing: 'freshman',
                                      first: Date.new(2021, 6, 29),
                                      last: Date.new(2021, 6, 30),
                                      term:)
      travel_to Time.zone.local(2021, 6, 18)
      assert_predicate(term, :live_enrollment?)
    end

    it 'returns false if the current date is not during the enrollment times' do
      term = create :term, term: '21F',
                           start_date: Date.new(2021, 9, 23),
                           end_date: Date.new(2021, 12, 22)
      create(:enrollment_appointment, pass: 'priority',
                                      first: Date.new(2021, 6, 14),
                                      last: Date.new(2021, 6, 16),
                                      term:)
      create(:enrollment_appointment, pass: 'second',
                                      standing: 'freshman',
                                      first: Date.new(2021, 6, 29),
                                      last: Date.new(2021, 6, 30),
                                      term:)
      travel_to Time.zone.local(2021, 7, 12)
      assert_not(term.live_enrollment?)
    end
  end

  describe 'upcoming' do
    it 'returns winter of the next year when the current term is fall' do
      create :term, term: '21F',
                    start_date: Date.new(2021, 9, 20),
                    end_date: Date.new(2021, 12, 10)
      upcoming = create :term, term: '22W',
                               start_date: Date.new(2022, 1, 3),
                               end_date: Date.new(2022, 3, 18)

      travel_to Time.zone.local(2021, 10, 4)
      assert_equal(1, Term.upcoming.length)
      assert_equal(upcoming.term, T.must(Term.upcoming.first).term)
    end

    it 'returns spring and summer when the current term is winter' do
      create :term, term: '22W',
                    start_date: Date.new(2022, 1, 3),
                    end_date: Date.new(2022, 3, 18)
      spring = create :term, term: '22S',
                             start_date: Date.new(2022, 3, 23),
                             end_date: Date.new(2022, 6, 10)
      summer = create :term, term: '221',
                             start_date: Date.new(2022, 6, 20),
                             end_date: Date.new(2022, 9, 9)

      travel_to Time.zone.local(2022, 2, 4)
      assert_equal(2, Term.upcoming.length)
      assert_equal(spring.term, T.must(Term.upcoming.first).term)
      assert_equal(summer.term, T.must(Term.upcoming.second).term)
    end

    it 'returns summer and fall when the current term is spring' do
      create :term, term: '22S',
                    start_date: Date.new(2022, 3, 23),
                    end_date: Date.new(2022, 6, 10)
      summer = create :term, term: '221',
                             start_date: Date.new(2022, 6, 20),
                             end_date: Date.new(2022, 9, 9)
      fall = create :term, term: '22F',
                           start_date: Date.new(2022, 9, 19),
                           end_date: Date.new(2022, 12, 9)

      travel_to Time.zone.local(2022, 5, 4)
      assert_equal(2, Term.upcoming.length)
      assert_equal(summer.term, T.must(Term.upcoming.first).term)
      assert_equal(fall.term, T.must(Term.upcoming.second).term)
    end

    it 'returns fall when the current term is summer' do
      create :term, term: '221',
                    start_date: Date.new(2022, 6, 20),
                    end_date: Date.new(2022, 9, 9)
      fall = create :term, term: '22F',
                           start_date: Date.new(2022, 9, 19),
                           end_date: Date.new(2022, 12, 9)

      travel_to Time.zone.local(2022, 8, 4)
      assert_equal(1, Term.upcoming.length)
      assert_equal(fall.term, T.must(Term.upcoming.first).term)
    end
  end
end
