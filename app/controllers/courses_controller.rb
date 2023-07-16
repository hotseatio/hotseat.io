# typed: strict
# frozen_string_literal: true

class CoursesController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super
    @courses = T.let(nil, T.nilable(Course::RelationType))
    @course = T.let(nil, T.nilable(Course))
    @superseding_course = T.let(nil, T.nilable(Course))
    @preceding_course = T.let(nil, T.nilable(Course))
    @subject_area = T.let(nil, T.nilable(SubjectArea))
    @term = T.let(nil, T.nilable(Term))
    @sections = T.let(Section.none, Section::RelationType)
    @instructor = T.let(nil, T.nilable(Instructor))
    @instructors_and_latest_term = T.let(nil, T.nilable(T::Array[[Instructor, Term]]))
    @reviews = T.let(nil, T.nilable(Review::RelationType))
    @comments = T.let(nil, T.nilable(Review::RelationType))

    @upcoming_terms = T.let(nil, T.nilable(T::Array[Term]))
    @sections_by_term = T.let(nil, T.nilable(T::Hash[Term, T::Array[Section]]))
    @previous_terms = T.let(nil, T.nilable(T::Array[Term]))

    @most_recent_term = T.let(nil, T.nilable(Term))
    @most_recent_sections = T.let(nil, T.nilable(T::Array[Section]))
    @enrollment_data = T.let(nil, T.nilable(T::Array[T::Hash[Symbol, T.untyped]]))
    @grade_data = T.let(nil, T.nilable(T::Array[{ term: String, grades: T::Array[Float] }]))
    @section_list = T.let(nil, T.nilable(T::Array[[String,
                                                   {
                                                     enrollmentPeriod: String,
                                                     sections: T::Array[SectionHelper::SectionListItem],
                                                   }]]))
    @textbooks = T.let(nil, T.nilable(Textbook::RelationType))
  end

  class IndexParams < T::Struct
    const :q, T.nilable(String)
    const :page, T.nilable(Integer)
  end

  # GET /courses
  sig { void }
  def index
    typed_params = TypedParams.extract!(IndexParams, params)
    page = typed_params.page
    query = typed_params.q
    @term = Term.current
    @courses = if query.nil?
                 Course.order_by_number.includes(:subject_area, :terms).with_only_offered_section_counts(@term).page(page)
               else
                 Course.search(query, page:, per_page: 20)
               end
  end

  class ShowParams < T::Struct
    const :id, Integer
  end

  # GET /courses/:id
  sig { void }
  def show
    typed_params = TypedParams.extract!(ShowParams, params)
    setup_instructors_tab_variables(typed_params.id)
    return if @instructors_and_latest_term.blank?

    # Redirect to first instructor if there is one
    first_instructor = @instructors_and_latest_term.first&.first
    redirect_to(action: "show_instructor", course_id: typed_params.id, id: first_instructor.id) if first_instructor
  end

  class ShowInstructorParams < T::Struct
    const :course_id, Integer
    const :id, Integer
    const :page, T.nilable(Integer)
  end

  # GET /courses/:course_id/instructors/:id
  sig { void }
  def show_instructor
    typed_params = TypedParams.extract!(ShowInstructorParams, params)
    setup_instructors_tab_variables(typed_params.course_id)

    @instructor = Instructor.find(typed_params.id)
    course_sections = @instructor.sections.includes(:grade_distribution,
                                                    :enrollment_data,
                                                    term: :enrollment_appointments)
                                 .where(course_id: T.must(@course).id)
                                 .where.not(index: nil)
    raise ActionController::RoutingError, "Not Found" if course_sections.empty?

    @reviews = @instructor.reviews.viewable.merge(course_sections)
    @comments = @reviews.viewable.has_comment.page(typed_params.page).per(10)

    @sections_by_term = course_sections.group_by(&:term)
    sorted_sections_by_term = @sections_by_term.sort_by(&:first).reverse
    @most_recent_term = sorted_sections_by_term.first&.first

    @textbooks = T.must(@sections_by_term[T.must(@most_recent_term)]).first&.textbooks

    @previous_terms = @sections_by_term.keys.sort.reverse

    @enrollment_data = helpers.generate_enrollment_data(sorted_sections_by_term)
    @grade_data = sorted_sections_by_term.filter_map do |term, sections|
      # Sections under the same term and instructor have the same distribution
      section = sections.first
      if section&.grade_distribution
        {
          term: term.short_readable,
          grades: section.grade_distribution.to_a,
        }
      end
    end

    @section_list = sorted_sections_by_term.map do |term, sections|
      [term.short_readable, {
        enrollmentPeriod: term.enrollment_period.serialize,
        sections: sections.sort.map do |section|
                    helpers.to_section_list_props(section, current_user,
                                                  display_type: SectionHelper::SectionListType::CoursePage)
                  end,
      }]
    end
  end

  private

  sig { params(course_id: Integer).void }
  def setup_instructors_tab_variables(course_id)
    @term = Term.current
    @course = Course.find(course_id)
    @subject_area = @course.subject_area

    @superseding_course = @course.superseding_course_with_subject
    @preceding_course = @course.preceding_course_with_subject

    @upcoming_terms = Term.upcoming.to_a
    # Sorbet can't handle a direct assignment
    tmp = T.cast(@course.sections.includes(:instructor, :term)
      .group_by(&:instructor)
      .transform_values { |a| a.map(&:term).max }
      .filter { |i, t| i.present? && t.present? }
      # Shouldn't have any nil instructors or terms, they're filtered out
      .sort_by { |_i, t| T.must(t) }
      .reverse, T::Array[[Instructor, Term]])
    @instructors_and_latest_term = tmp
  end
end
