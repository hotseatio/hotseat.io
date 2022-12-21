# typed: strict
# frozen_string_literal: true

class Term < ApplicationRecord
  extend T::Sig
  include Comparable

  QUARTER_WEIGHTS = T.let({
    "Winter" => 1,
    "Spring" => 2,
    "Summer" => 3,
    "Fall" => 4,
  }.freeze, T::Hash[String, Integer])

  scope :order_chronologically_asc, lambda {
                                      order(
                                        Arel.sql("to_date(SUBSTRING(term FOR 2), 'YY')"),
                                        Arel.sql("CASE SUBSTRING(term FROM 3 FOR 1) WHEN 'W' THEN 1 WHEN 'S' THEN 2 WHEN '1' THEN 3 WHEN 'F' THEN 4 END"),
                                      )
                                    }

  scope :order_chronologically_desc, lambda {
                                       order(
                                         Arel.sql("to_date(SUBSTRING(term FOR 2), 'YY')") => :desc,
                                         Arel.sql("CASE SUBSTRING(term FROM 3 FOR 1) WHEN 'W' THEN 1 WHEN 'S' THEN 2 WHEN '1' THEN 3 WHEN 'F' THEN 4 END") => :desc,
                                       )
                                     }

  scope :current_and_upcoming, lambda {
    upcoming.or(where(id: current))
  }

  has_many :sections, dependent: :restrict_with_exception
  has_many :enrollment_appointments, dependent: :restrict_with_exception

  has_many :courses, -> { distinct.reorder("") }, through: :sections
  has_many :subject_areas, -> { distinct.reorder("") }, through: :courses

  enum summer_session: {
    A: "A",
    B: "B",
    C: "C",
    D: "D",
  }

  sig { returns(Term) }
  def self.current
    T.must(where("start_date < ?", Time.zone.today).order("start_date DESC").limit(1).first)
  end

  sig { returns(Term::RelationType) }
  def self.upcoming
    current_term = current
    short_year = current_term.short_year
    case current_term.quarter
    when "Fall" # Upcoming: Winter (of next year)
      next_year = short_year.to_i + 1
      winter_term = "#{next_year}W"
      where(term: winter_term)
    when "Winter" # Upcoming: Spring, Summer
      spring_term = "#{short_year}S"
      summer_term = "#{short_year}1"
      where(term: spring_term).or(where(term: summer_term))
    when "Spring" # Upcoming: Summer, Fall
      summer_term = "#{short_year}1"
      fall_term = "#{short_year}F"
      where(term: summer_term).or(where(term: fall_term))
    when "Summer" # Upcoming: Fall
      fall_term = "#{short_year}F"
      where(term: fall_term)
    else
      none
    end
  end

  sig { returns(T::Boolean) }
  def self.should_show_upcoming?
    current_term = current
    current_term.after_week_four? || current_term.summer?
  end

  # 1 if self>other; 0 if self==other; -1 if self<other
  sig { params(other: Term).returns(T.nilable(Integer)) }
  def <=>(other)
    year_comparison = year <=> other.year
    return year_comparison if year_comparison.nil? || !year_comparison.zero?

    T.must(QUARTER_WEIGHTS[quarter]) <=> T.must(QUARTER_WEIGHTS[other.quarter])
  end

  sig { returns(String) }
  def readable
    "#{quarter} #{year}"
  end

  sig { returns(String) }
  def short_readable
    "#{short_year}#{short_quarter}"
  end

  sig { returns(String) }
  def year
    (term[0] == "9" ? "19" : "20") + T.must(term[0..1])
  end

  sig { returns(String) }
  def quarter
    case term[2]
    when "F"
      "Fall"
    when "W"
      "Winter"
    when "S"
      "Spring"
    when "1"
      "Summer"
    else
      T.must(term[2])
    end
  end

  sig { returns(String) }
  def short_year
    T.must(term[0..1])
  end

  sig { returns(String) }
  def short_quarter
    case term[2]
    when "1"
      "Su"
    else
      T.must(term[2])
    end
  end

  sig { returns(T::Boolean) }
  def summer?
    quarter == "Summer"
  end

  sig { returns(T.nilable(T::Boolean)) }
  def zero_week?
    # If the term doesn't start on Monday, we have a zero week!
    !start_date&.monday?
  end

  sig { returns(T.nilable(T::Boolean)) }
  def after_week_four?
    week = current_week
    return nil if week.nil?

    week > 4
  end

  sig { returns(T.nilable(Integer)) }
  def current_week
    today = Time.zone.today
    return nil if start_date.nil? || today < start_date || summer?

    # Handle zero week
    week1_start = T.must(start_date)
    week1_start = T.must(start_date).next_occurring(:monday) if zero_week?
    week_number = T.cast((today - week1_start).days.in_weeks, Float)

    if week_number.negative?
      0
    else
      week_number.to_i + 1
    end
  end

  # A human-readable label of the current week, e.g., "Week 5"
  # Returns `nil` if the term hasn't started. Returns the name of the
  # break after the term.
  sig { returns(T.nilable(String)) }
  def current_week_label
    # Handle summer session
    return nil if summer?

    case current_week
    when 0..10
      "Week #{current_week}"
    when 11
      "Finals Week"
    when (12..)
      post_term_break
    end
  end

  sig { returns(T.nilable(String)) }
  def term_and_week
    week = current_week_label
    if week.nil?
      readable
    else
      "#{week}, #{readable}"
    end
  end

  sig { returns(T.nilable(String)) }
  def post_term_break
    case quarter
    when "Fall"
      "Winter Break"
    when "Winter"
      "Spring Break"
    when "Spring", "Summer"
      "Summer Break"
    end
  end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def enrollment_start
    priority_pass = enrollment_appointments.find_by(pass: "priority")
    priority_pass&.first
  end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def enrollment_end
    freshmen_second_pass = enrollment_appointments.find_by(pass: "second", standing: "freshman")
    (freshmen_second_pass.last + 10.days).at_end_of_day if freshmen_second_pass
  end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def start_time
    start_date&.at_beginning_of_day
  end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def end_of_week_two_time
    return nil if start_date.nil?

    (T.must(start_date) + T.unsafe(zero_week? ? 2.weeks : 1.week)).next_occurring(:friday).at_end_of_day
  end

  # Returns true if it is currently during the first two weeks of the quarter.
  # 0th week is considered to be in this time period.
  sig { returns(T::Boolean) }
  def first_two_weeks?
    self.class.currently_between_times?(start_time, end_of_week_two_time)
  end

  sig { returns(T::Boolean) }
  def live_enrollment?
    self.class.currently_between_times?(enrollment_start, enrollment_end)
  end

  class EnrollmentPeriod < T::Enum
    enums do
      Pre = new
      Current = new
      Post = new
    end
  end

  sig { returns(EnrollmentPeriod) }
  def enrollment_period
    return EnrollmentPeriod::Post if after_week_four? || enrollment_start.nil?
    return EnrollmentPeriod::Pre if Time.zone.now.before?(enrollment_start)

    EnrollmentPeriod::Current
  end

  class EnrollmentChartMarker < T::Struct
    const :label, String
    const :time, ActiveSupport::TimeWithZone
  end

  # Creates a hash of the start time of each enrollment pass.
  # Example:
  # {
  #   "priority"=>Thu, 18 Mar 2021 18:30:32.022154000 UTC +00:00,
  #   "first"=>Mon, 22 Mar 2021 18:30:32.022154000 UTC +00:00,
  #   "second"=>Mon, 29 Mar 2021 18:30:32.022154000 UTC +00:00
  # }
  sig { returns(T.nilable(T::Array[EnrollmentChartMarker])) }
  def enrollment_period_markers
    enrollment_appointments
      .where.not(pass: "graduate")
      .group(:pass)
      .minimum(:first)
      .map { |pass, time| EnrollmentChartMarker.new(label: pass.humanize, time:) }
  end

  sig { returns(T::Array[EnrollmentChartMarker]) }
  def quarter_start_markers
    week1_start = T.must(start_date)
    week1_start = T.must(start_date).next_occurring(:monday) if zero_week?
    week2_start = week1_start + T.unsafe(1.week)

    [
      EnrollmentChartMarker.new(
        label: "Week 1",
        time: week1_start.at_beginning_of_day,
      ),
      EnrollmentChartMarker.new(
        label: "Week 2",
        time: week2_start.at_beginning_of_day,
      ),
    ]
  end

  sig { params(start_time: T.nilable(ActiveSupport::TimeWithZone), end_time: T.nilable(ActiveSupport::TimeWithZone)).returns(T::Boolean) }
  def self.currently_between_times?(start_time, end_time)
    return false if start_time.nil? || end_time.nil?

    Time.zone.now.between?(start_time, end_time)
  end
end
