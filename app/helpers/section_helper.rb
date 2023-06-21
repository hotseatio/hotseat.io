# typed: strict
# frozen_string_literal: true

module SectionHelper
  extend T::Sig
  include ColorHelper

  class BadgeColor < T::Struct
    const :text, String
    const :background, String
  end

  class SectionListItem < T::Struct
    const :id, Integer
    const :title, String
    const :instructorCount, T.nilable(Integer)
    const :instructorLabel, T.nilable(String)
    const :timeLabel, T.nilable(String)
    const :locationLabel, T.nilable(String)
    const :termLabel, T.nilable(String)
    const :isFollowed, T::Boolean
    const :isSubscribed, T::Boolean
    const :isReviewed, T::Boolean
    const :detailsLink, String
    const :badgeLabel, T.nilable(String)
    const :badgeColor, T.nilable(BadgeColor)
  end

  class SectionListType < T::Enum
    extend T::Sig

    enums do
      CoursePage = new
      MyCoursesPageCurrent = new
      MyCoursesPagePrevious = new
    end

    sig { returns(T::Boolean) }
    def my_courses?
      case self
      when CoursePage then false
      when MyCoursesPageCurrent, MyCoursesPagePrevious then true
      else
        T.absurd(self)
      end
    end
  end

  # Returns the badge label for a section.
  sig { params(section: Section).returns(String) }
  def section_badge_label(section)
    case section.enrollment_status
    when "Open"
      "Open (#{pluralize(section.available_seats, 'seats')})"
    when "Waitlist"
      "Waitlist (#{pluralize(section.available_waitlist_seats, 'seats')})"
    else
      section.enrollment_status
    end
  end

  sig { params(section: Section).returns(ColorHelper::Color) }
  def section_badge_color(section)
    case section.enrollment_status
    when "Open"
      ColorHelper::Color::Green
    when "Waitlist"
      ColorHelper::Color::Yellow
    when "Closed", "Full", "Canceled"
      ColorHelper::Color::Red
    else
      ColorHelper::Color::Gray
    end
  end

  sig { params(section: Section, current_user: T.nilable(User), display_type: SectionListType, hide_badge: T::Boolean).returns(SectionListItem) }
  def to_section_list_props(section, current_user, display_type:, hide_badge: false)
    color = section_badge_color(section)
    badge_color = BadgeColor.new(
      text: text800(color),
      background: bg(color, ColorHelper::Shade::OneHundred),
    )

    is_followed = T.let(current_user&.following?(section).presence || false, T::Boolean)
    is_subscribed = T.let(current_user&.subscribed_to_section?(section).presence || false, T::Boolean)
    is_reviewed = T.let(current_user&.reviewed_section?(section).presence || false, T::Boolean)

    time_label = section.time_label
    location_label = section.location_label
    term_label = nil
    if display_type == SectionListType::MyCoursesPagePrevious
      time_label = nil
      location_label = nil
      term_label = section.term.readable
    end

    SectionListItem.new(
      id: section.id,
      title: display_type.my_courses? ? section.course_title : section.title,
      instructorCount: display_type.my_courses? ? section.instructor_count : nil,
      instructorLabel: display_type.my_courses? ? section.instructors_label : nil,
      timeLabel: time_label,
      locationLabel: location_label,
      termLabel: term_label,
      isFollowed: is_followed,
      isSubscribed: is_subscribed,
      isReviewed: is_reviewed,
      detailsLink: if display_type.my_courses?
                     if section.instructor.present?
                       course_instructor_path(section.course, section.instructor)
                     else
                       course_path(section.course)
                     end
                   else
                     section.registrar_link
                   end,
      badgeLabel: hide_badge ? nil : section_badge_label(section),
      badgeColor: hide_badge ? nil : badge_color,
    )
  end
end
