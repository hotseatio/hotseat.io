# typed: strict
# frozen_string_literal: true

class HomePageController < ApplicationController
  extend T::Sig

  before_action :redirect_if_authenticated
  layout 'homepage'

  COURSE_INSTRUCTOR_PAIRS = T.let([
    ['COM SCI', '32', 'Nachenberg'],
  ].freeze, T::Array[[String, String, String]])

  sig { void }
  def initialize
    super
    @subject_areas = T.let(nil, T.nilable(SubjectArea::ActiveRecord_Relation))
    @term = T.let(nil, T.nilable(Term))
    @course = T.let(nil, T.nilable(Course))
    @reviews = T.let(nil, T.nilable(Review::RelationType))
    @sections_by_term = T.let(nil, T.nilable(T::Array[[Term, T::Array[Section]]]))
  end

  sig { void }
  def index
    @term = Term.current
    @subject_areas = SubjectArea.most_popular.shuffle

    subject_area, number, instructor_name = COURSE_INSTRUCTOR_PAIRS.sample

    @course = T.must(Course.joins(:subject_area).find_by('subject_area.code': subject_area, number:))
    instructor = T.must(Instructor.find_by(last_names: [instructor_name]))
    course_sections = instructor.sections.includes(:grade_distribution,
                                                   :enrollment_data,
                                                   term: :enrollment_appointments)
                                .where(course_id: @course.id)
    @reviews = instructor.reviews.viewable.merge(course_sections)
    @sections_by_term = course_sections.group_by(&:term).sort_by(&:first).reverse
  end

  private

  sig { void }
  def redirect_if_authenticated
    redirect_to(my_courses_path) if user_signed_in?
  end
end
