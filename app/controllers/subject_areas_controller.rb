# typed: strict
# frozen_string_literal: true

class SubjectAreasController < ApplicationController
  extend T::Sig

  class IndexParams < T::Struct
    const :page, T.nilable(Integer)
  end

  class ShowParams < T::Struct
    const :id, Integer
    const :page, T.nilable(Integer)
    const :filter, T.nilable(String)
  end

  sig { void }
  def initialize
    super
    @subject_areas = T.let(nil, T.nilable(SubjectArea::RelationType))
    @subject_area = T.let(nil, T.nilable(SubjectArea))
    @courses = T.let(nil, T.nilable(Course::RelationType))
    @term = T.let(nil, T.nilable(Term))
    @upcoming_terms = T.let(nil, T.nilable(T::Array[Term]))
    @filter_option = T.let(nil, T.nilable(T.any(SubjectAreaHelper::FilterOption, Term)))
    @filter_options = T.let(nil, T.nilable(Term::RelationType))
  end

  sig { void }
  def index
    typed_params = TypedParams.extract!(IndexParams, params)
    page = typed_params.page

    @term = Term.current
    @subject_areas = SubjectArea.active.order_by_name.page(page)
  end

  sig { void }
  def show
    typed_params = TypedParams.extract!(ShowParams, params)
    page = typed_params.page

    @term = Term.current
    @upcoming_terms = Term.upcoming.to_a
    @subject_area = SubjectArea.find(typed_params.id)

    @filter_option = if typed_params.filter == "all"
                       SubjectAreaHelper::FilterOption::All
                     elsif typed_params.filter.present?
                       Term.find_by!(term: typed_params.filter)
                     elsif Term.should_show_upcoming? && Term.upcoming.any?
                       Term.upcoming.first
                     else
                       Term.current
                     end

    # Show up to three years of courses.
    @filter_options = Term.where("start_date < ?", Time.zone.today)
    @filter_options = @filter_options.or(Term.upcoming) if Term.should_show_upcoming?
    @filter_options = @filter_options.order("start_date DESC").limit(12)

    @courses = @subject_area.courses.active.order_by_number.page(page)
    @courses = if @filter_option.is_a?(SubjectAreaHelper::FilterOption) && @filter_option == SubjectAreaHelper::FilterOption::All
                 @courses.with_section_counts
               else
                 @courses.with_only_offered_section_counts(@filter_option)
               end
  end
end
