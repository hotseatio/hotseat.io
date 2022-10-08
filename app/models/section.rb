# typed: strict
# frozen_string_literal: true

class Section < ApplicationRecord
  extend T::Sig

  scope :order_by_course, -> { merge(Course.order_by_number) }
  scope :order_by_index, -> { order('index ASC') }

  belongs_to :course
  belongs_to :term
  belongs_to :instructor, optional: true

  has_one :grade_distribution, dependent: :restrict_with_exception

  has_many :enrollment_data, dependent: :restrict_with_exception, inverse_of: :section
  has_many :relationships, dependent: :restrict_with_exception
  has_many :reviews, through: :relationships

  has_and_belongs_to_many :textbooks

  sig { params(other: Section).returns(T.nilable(Integer)) }
  def <=>(other)
    index <=> T.must(other.index) unless index.nil? || other.index.nil?
  end

  sig { returns(String) }
  def title
    "#{format} #{index}"
  end

  sig { returns(String) }
  def course_title
    c = T.must(course)
    "#{c.short_title}: #{c.title}"
  end

  sig { returns(String) }
  def time_label
    "#{days.join(', ')} #{times.join(', ')}"
  end

  sig { returns(String) }
  def location_label
    locations.join(', ')
  end

  sig { returns(Integer) }
  def instructor_count
    if instructor.nil?
      registrar_instructors.count
    else
      T.must(instructor).name_count
    end
  end

  sig { returns(String) }
  def instructors_label
    if instructor.nil?
      registrar_instructor_label
    else
      T.must(instructor).short_label
    end
  end

  sig { returns(String) }
  def registrar_instructor_label
    registrar_instructors.join('; ')
  end

  sig { returns(String) }
  def registrar_link
    query_params = {
      term_cd: T.must(term).term,
      subj_area_cd: T.must(course).subject_area_code.ljust(7),
      crs_catlg_no: T.must(course).catalog_number.ljust(7),
      class_id: registrar_id,
      class_no: Kernel.format(' %03d  ', index),
    }
    "https://sa.ucla.edu/ro/Public/SOC/Results/ClassDetail?#{query_params.to_query}"
  end

  sig { returns(String) }
  def enroll_link
    query_params = {
      t: T.must(term).term,
      sBy: 'subject',
      subj: T.must(course).subject_area_code,
      crsCatlg: "#{T.must(course).number} - #{T.must(course).title}",
      catlg: T.must(course).catalog_number,
      cls_no: '%',
    }
    "https://sa.ucla.edu/ro/ClassSearch/Results?#{query_params.to_query}"
  end

  # The number of available open seats for the section.
  sig { returns(Integer) }
  def available_seats
    enrollment_capacity - enrollment_count
  end

  # The number of available waitlist seats for the section.
  sig { returns(Integer) }
  def available_waitlist_seats
    waitlist_capacity - waitlist_count
  end

  # The formatted data for a section's enrollment during the term's enrollment period.
  sig { returns(T.nilable(T::Array[T::Hash[String, T.any(Integer, String)]])) }
  def enrollment_period_data_props
    enrollment_start = T.must(term).enrollment_start
    enrollment_end = T.must(term).enrollment_end
    enrollment_data.where(created_at: enrollment_start..enrollment_end).order(:created_at).as_json.map { |datum| datum.transform_keys! { |k| k.camelcase(:lower) } } if enrollment_start.present? && enrollment_end.present?
  end

  # The formatted data for a section's enrollment during the first few weeks of the term.
  sig { returns(T.nilable(T::Array[T::Hash[String, T.any(Integer, String)]])) }
  def quarter_start_enrollment_data_props
    enrollment_start = T.must(term).start_time
    return if enrollment_start.nil?

    enrollment_end = T.must(term).end_of_week_two_time

    data_props = enrollment_data
                 .where(created_at: enrollment_start..enrollment_end)
                 .order(:created_at)
                 .as_json

    # Insert data for enrollment start
    data_before_enrollment = enrollment_data
                             .where('created_at < ?', enrollment_start)
                             .order(created_at: :desc)
                             .first
                             .as_json
    unless data_before_enrollment.blank? || data_props.blank?
      data_before_enrollment['created_at'] = enrollment_start
      data_props.prepend(data_before_enrollment)
    end

    data_props.map { |datum| datum.transform_keys! { |k| k.camelcase(:lower) } }
  end

  class LocationType < T::Enum
    enums do
      InPerson = new('In-Person')
      Hybrid = new('Hybrid')
      Online = new('Online')
    end
  end

  sig { returns(LocationType) }
  def location_type
    online_locations = locations.select { |location| location.downcase.include?('online') }
    if online_locations.size == locations.size # all locations online
      LocationType::Online
    elsif online_locations.empty? # all locations in person
      LocationType::InPerson
    else
      LocationType::Hybrid
    end
  end
end
