# typed: strict
# frozen_string_literal: true

class Course < ApplicationRecord
  extend T::Sig
  searchkick word_middle: [:search_text], default_fields: [:search_text]

  validates :title,  presence: true
  validates :number, presence: true

  belongs_to :subject_area

  has_one :preceding_course,
          class_name: 'Course',
          foreign_key: 'superseding_course_id',
          inverse_of: :superseding_course,
          dependent: :restrict_with_exception
  belongs_to :superseding_course,
             class_name: 'Course',
             optional: true

  has_many :sections, dependent: :restrict_with_exception
  has_many :instructors, -> { distinct }, through: :sections
  has_many :terms, -> { distinct }, through: :sections

  scope :search_import, -> { includes(:subject_area) }
  scope :active, -> { where(superseding_course: nil) }
  scope :order_by_number, lambda {
    # Keep this in sync with Go code.
    order(Arel.sql(%q[SUBSTRING(number, '[0-9]+')::int NULLS FIRST,
                      SUBSTRING(number, '%[0-9]+#"[A-Za-z]+#"', '#') NULLS FIRST,
                      number,
                      title]))
  }

  scope :with_section_counts, lambda {
    current_term = Term.current
    raw_sql = <<~SQL.squish
      courses.*,
      (
        SELECT COUNT(sections.id) FROM sections
        WHERE course_id = courses.id
        AND term_id IN (:terms)
      ) AS section_count
    SQL
    sanitized_sql = sanitize_sql_for_assignment([
                                                  raw_sql,
                                                  if Term.should_show_upcoming?
                                                    { terms: Term.current_and_upcoming.pluck(:id) }
                                                  else
                                                    { terms: current_term.id }
                                                  end,
                                                ])
    select_columns(sanitized_sql)
  }

  scope :with_only_offered_section_counts, lambda { |term|
    raw_sql = <<~SQL.squish
      (
        SELECT COUNT(sections.id) FROM sections
        WHERE course_id = courses.id
        AND term_id IN (:terms)
      ) > 0
    SQL

    sanitized_sql = sanitize_sql_for_conditions([raw_sql, { terms: term.id }])
    with_section_counts.where(sanitized_sql)
  }

  delegate :code, to: :subject_area, prefix: true

  sig { returns(String) }
  def short_title
    "#{subject_area.code} #{number}"
  end

  sig { returns(T::Hash[Symbol, String]) }
  def search_data
    search_text = "#{subject_area.code} #{subject_area.name} #{number} #{title}" if superseding_course_with_subject.nil?
    {
      search_text:,
    }
  end

  sig { returns(String) }
  def long_title
    "#{subject_area.name} #{number}: #{title}"
  end

  # All the text that is searchable
  # Keep this in sync with lambdas/registrar/storage.go.
  sig { returns(String) }
  def searchable_title
    "#{subject_area.code} #{number} #{subject_area.name} #{title}"
  end

  # Whether a course is offered for a given term.
  sig { params(term: Term).returns(T::Boolean) }
  def offered_for_term?(term)
    terms.include? term
  end

  COURSE_NUMBER_REGEX = T.let(/([CM]*)([0-9]*)([A-Z]*)/, Regexp)

  # The catalog number for a course, which is just a specially formatted version of the course number.
  # Used as a parameter in some registrar URLs.
  # Example: `M151B` becomes `0151B M`
  sig { returns(String) }
  def catalog_number
    matches = T.cast(T.must(number.scan(COURSE_NUMBER_REGEX).first), T::Array[String])
    leading_chars = T.must(matches.first)
    number = T.must(matches.second)
    trailing_chars = T.must(matches.third)

    (number.rjust(4, '0') + trailing_chars.ljust(2) + leading_chars).strip
  end

  # Returns the course that replaced the current course, if one exists.
  # 1. If course has superseding course, go with that
  # 2. If subject area has superseding subject area, find by:
  #   - title and number
  #   - number
  sig { returns(T.nilable(Course)) }
  def superseding_course_with_subject
    return superseding_course if superseding_course.present?

    course = nil
    new_subject_area = subject_area.superseding_subject_area
    if new_subject_area.present?
      course = new_subject_area.courses.find_by(title:, number:)
      course = new_subject_area.courses.find_by(number:) if course.nil?
    end
    course
  end

  sig { returns(T.nilable(Course)) }
  def preceding_course_with_subject
    return preceding_course if preceding_course.present?

    course = nil
    prev_subject_area = subject_area.preceding_subject_area
    if prev_subject_area.present?
      course = prev_subject_area.courses.find_by(title:, number:)
      course = prev_subject_area.courses.find_by(number:) if course.nil?
    end
    course
  end
end
