# typed: strict
# frozen_string_literal: true

module CourseHelper
  extend T::Sig
  include ActionView::Helpers::TextHelper

  sig { params(sorted_sections_by_term: T::Array[[Term, T::Array[Section]]]).returns(T::Array[T::Hash[Symbol, T.untyped]]) }
  def generate_enrollment_data(sorted_sections_by_term)
    sorted_sections_by_term.filter_map do |term, sections|
      enrollment_period_data = sections.sort.filter_map do |section|
        data = section.enrollment_period_data_props
        { label: section.title, data: } if data.present?
      end
      quarter_start_data = sections.sort.filter_map do |section|
        data = section.quarter_start_enrollment_data_props
        { label: section.title, data: } if data.present?
      end

      if enrollment_period_data.present? || quarter_start_data.present?
        {
          term: term.short_readable,
          enrollmentPeriod: {
            start: term.enrollment_start,
            end: term.enrollment_end,
            markers: term.enrollment_period_markers,
            sections: enrollment_period_data,
            isLive: term.live_enrollment?,
          },
          quarterStart: {
            start: term.start_time,
            end: term.end_of_week_two_time,
            markers: term.quarter_start_markers,
            sections: quarter_start_data,
            isLive: term.first_two_weeks?,
          },
        }
      end
    end
  end

  sig { params(course: Course, instructor: T.nilable(Instructor)).returns(String) }
  def course_title(course, instructor = nil)
    if instructor
      "#{instructor.full_label} - #{course.short_title}"
    else
      course.short_title
    end
  end

  sig { params(course: Course, instructor: T.nilable(Instructor)).returns(String) }
  def course_description(course, instructor = nil)
    instructor_line = instructor.present? ? " with #{instructor.full_label}" : ""
    "#{course.long_title}#{instructor_line} reviews, textbooks, enrollment charts and more. Provided by Hotseat, UCLA's premier source for professors and classes."
  end

  sig { params(course: Course).returns(T.nilable(String)) }
  def course_badge_label(course)
    return nil unless course.respond_to?(:section_count)

    count = T.let(T.unsafe(course).section_count, T.nilable(Integer))
    if count.nil? || count.zero?
      "Not offered"
    else
      pluralize(count, "section")
    end
  end

  # Returns the badge color for a course.
  sig { params(badge_label: T.nilable(String), term_color: ColorHelper::Color).returns(T.nilable(ColorHelper::Color)) }
  def course_badge_color(badge_label, term_color: ColorHelper::Color::Green)
    case badge_label
    when nil
      nil
    when "Not offered"
      ColorHelper::Color::Gray
    else
      term_color
    end
  end

  sig { params(course_detail: { label: Symbol, value: T.any(Float, Integer, String, T::Boolean) }).returns(T.nilable(String)) }
  def course_detail_icon(course_detail)
    label = course_detail[:label]
    value = course_detail[:value]

    case label
    when :has_group_project
      if value
        "icons/user-group"
      else
        "icons/user"
      end
    when :final
      if value == "none"
        "icons/sun"
      else
        "icons/pencil-alt"
      end
    when :requires_attendance
      if value
        "icons/presentation-chart-bar"
      else
        "icons/sun"
      end
    when :midterm_count
      if value.zero?
        "icons/sun"
      else
        "icons/pencil-alt"
      end
    when :reccomend_textbook
      "icons/book-open"
    end
  end

  sig { params(course_detail: { label: Symbol, value: T.any(Float, Integer, String, T::Boolean) }).returns(String) }
  def course_detail_label(course_detail)
    label = course_detail[:label]
    value = course_detail[:value]

    case label
    when :has_group_project
      has_group_project = T.cast(value, T::Boolean)
      if has_group_project
        "Has a group project"
      else
        "No group projects"
      end
    when :requires_attendance
      requires_attendance = T.cast(value, T::Boolean)
      if requires_attendance
        "Attendance required"
      else
        "Attendance not required"
      end
    when :final
      final_labels = {
        "none" => "No final",
        "10th" => "10th week final",
        "finals" => "Finals week final",
      }
      final_labels[value]
    when :midterm_count
      pluralize(value, "midterm")
    when :reccomend_textbook
      # Check if value is boolean
      case value
      when true
        'Recommends textbook'
      when false
        'Does not recommend textbook'
      else
        # Not boolean, is a number
        "#{number_to_percentage(value, precision: 0)} recommend the textbook"
      end
    end
  end
end
