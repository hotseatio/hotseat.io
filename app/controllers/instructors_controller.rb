# typed: strict
# frozen_string_literal: true

class InstructorsController < ApplicationController
  extend T::Sig

  class IndexParams < T::Struct
    const :page, T.nilable(Integer)
  end

  class ShowParams < T::Struct
    const :id, Integer
    const :page, T.nilable(Integer)
  end

  sig { void }
  def initialize
    super
    @instructors = T.let(Instructor.none, Instructor::ActiveRecord_Relation)
    @instructor = T.let(nil, T.nilable(Instructor))
    @courses = T.let(nil, T.nilable(Course::ActiveRecord_Relation))
    @term = T.let(nil, T.nilable(Term))
  end

  # GET /instructors
  sig { void }
  def index
    typed_params = TypedParams[IndexParams].new.extract!(params)
    page = typed_params.page
    @instructors = Instructor.all.page(page)
  end

  # GET /instructors/:id
  sig { void }
  def show
    typed_params = TypedParams[ShowParams].new.extract!(params)
    @instructor = Instructor.find typed_params.id
    @term = Term.current
    @courses = Course.from(@instructor.courses, :courses).includes(:subject_area).order_by_number.page(typed_params.page)
  end
end
