# typed: strict
# frozen_string_literal: true

class ReviewsController < ApplicationController
  extend T::Sig

  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  class ReviewParams < T::Struct
    const :section_id, String
    const :grade, T.nilable(String)
    const :organization, Integer
    const :clarity, Integer
    const :overall, Integer
    const :weekly_time, String
    const :group_project, T::Boolean
    const :extra_credit, T::Boolean
    const :attendance, T::Boolean
    const :midterm_count, Integer
    const :final, String
    const :textbook, T::Boolean
    const :comments, String
  end

  class NewParams < T::Struct
    const :course, T.nilable(Integer)
    const :section, T.nilable(Integer)
  end

  class CreateParams < T::Struct
    const :review, ReviewParams
  end

  class EditParams < T::Struct
    const :id, Integer
  end

  class UpdateParams < T::Struct
    const :id, Integer
    const :review, ReviewParams
  end

  class CourseSuggestionsParams < T::Struct
    const :q, String
  end

  class TermSuggestionsParams < T::Struct
    const :course_id, String
  end

  class SectionSuggestionsParams < T::Struct
    const :course_id, Integer
    const :term, String
  end

  sig { void }
  def initialize
    super
    @review = T.let(nil, T.nilable(Review))
    @initial_suggestion_type = T.let(nil, T.nilable(String))
    @course = T.let(nil, T.nilable(Course))
    @term = T.let(nil, T.nilable(Term))
    @section = T.let(nil, T.nilable(Section))
    @sections = T.let(Section.none, T.any(Section::ActiveRecord_Relation, Section::ActiveRecord_AssociationRelation))
    @results = T.let(nil, T.untyped)
  end

  sig { void }
  def new
    typed_params = TypedParams[NewParams].new.extract!(params)
    @review = Review.new

    if typed_params.section.present?
      @section = Section.find(typed_params.section)
      @initial_suggestion_type = "section"
      @course = @section.course
      @term = @section.term
      @sections = Section.where(course_id: @course.id, term_id: @term.id)
                         .includes(:term, :instructor)
                         .order(:index)
    elsif typed_params.course.present?
      @course = Course.find(typed_params.course)
      @initial_suggestion_type = "course"
    end
  end

  # GET /reviews/:id/edit
  sig { void }
  def edit
    typed_params = TypedParams[EditParams].new.extract!(params)
    @review = Review.find(typed_params.id)

    if current_user != @review.user
      flash[:error] = "You can't edit a review that isn't yours."
      redirect_back_or_to(my_courses_path)
    end

    @section = T.must(@review.section)
    @initial_suggestion_type = "section"
    @course = @section.course
    @term = @section.term
    @sections = Section.where(course_id: @course.id, term_id: @term.id)
                       .includes(:term, :instructor)
                       .order(:index)
  end

  sig { void }
  def create
    typed_params = TypedParams[CreateParams].new.extract!(params)
    review_params = typed_params.review
    # This action requires authentication, so we're guaranteed a user
    user = T.must(current_user)

    return unless review_valid?(review_params, user)

    is_first_review = T.let(user.reviews.size.zero?, T::Boolean)

    relationship = Relationship.find_or_create_by(
      section_id: review_params.section_id,
      user_id: user.id,
    )
    review = relationship.create_review(
      grade: review_params.grade,
      organization: review_params.organization,
      weekly_time: review_params.weekly_time,
      clarity: review_params.clarity,
      overall: review_params.overall,
      has_group_project: review_params.group_project,
      offers_extra_credit: review_params.extra_credit,
      requires_attendance: review_params.attendance,
      midterm_count: review_params.midterm_count,
      final: review_params.final,
      reccomend_textbook: review_params.textbook,
      comments: review_params.comments,
    )

    logger.info("Queueing NotifyOnNewReviewJob")
    NotifyOnNewReviewJob.perform_later(review)

    # Flash doesn't work here since we do the redirect through js,
    # so we store a session variable instead
    if is_first_review && user.referred_by
      session[:referred_review_created] = true
      user.complete_referral!
    else
      session[:review_created] = true
    end

    # Disable turbolinks here, we handle the redirect in JS
    redirect_to(my_courses_path, turbolinks: false)
  rescue ActionController::BadRequest => e
    logger.error(e.inspect)
    render(json: { msg: "Could not create review. Make sure you fill out the class and all questions." }, status: :bad_request)
  end

  # PUT/PATCH /reviews/:id
  sig { void }
  def update
    typed_params = TypedParams[UpdateParams].new.extract!(params)
    @review = Review.find(typed_params.id)
    review_params = typed_params.review
    # This action requires authentication, so we're guaranteed a user
    user = T.must(current_user)

    if user != @review.user
      render(json: { msg: "You can't edit a review that isn't yours." }, status: :bad_request)
      return
    end

    return unless review_valid?(review_params, user, existing_review: true)

    @review.update(
      grade: review_params.grade,
      organization: review_params.organization,
      weekly_time: review_params.weekly_time,
      clarity: review_params.clarity,
      overall: review_params.overall,
      has_group_project: review_params.group_project,
      offers_extra_credit: review_params.extra_credit,
      requires_attendance: review_params.attendance,
      midterm_count: review_params.midterm_count,
      final: review_params.final,
      reccomend_textbook: review_params.textbook,
      comments: review_params.comments,
    )

    session[:review_updated] = true

    # Disable turbolinks here, we handle the redirect in JS
    # Some browsers will try to follow the redirect using the original request method (PUT/PATCH). Use 303 to force GET of /my-courses.
    redirect_to(my_courses_path, turbolinks: false, status: :see_other)
  rescue ActionController::BadRequest => e
    logger.error(e.inspect)
    render(json: { msg: "Could not update review. Make sure you fill out the class and all questions." }, status: :bad_request)
  end

  sig { void }
  def course_suggestions
    typed_params = TypedParams[CourseSuggestionsParams].new.extract!(params)
    @results = Course.search(typed_params.q, limit: 8, track: true)
    render(formats: :json)
  end

  sig { void }
  def term_suggestions
    typed_params = TypedParams[TermSuggestionsParams].new.extract!(params)
    @course = Course.find(typed_params.course_id)
    render(formats: :json)
  end

  sig { void }
  def section_suggestions
    typed_params = TypedParams[SectionSuggestionsParams].new.extract!(params)
    @term = Term.find_by(term: typed_params.term)
    return unless @term

    @sections = Section.where(course_id: typed_params.course_id, term_id: @term.id)
                       .includes(:term, :instructor)
                       .order(:index)
    render(formats: :json)
  end

  private

  sig { params(review_params: ReviewParams, user: User, existing_review: T::Boolean).returns(T::Boolean) }
  def review_valid?(review_params, user, existing_review: false)
    section = Section.find(review_params.section_id)

    if user.review_count_for_term(section.term) >= 6
      render(json: { msg: "You can only review six classes per term." }, status: :bad_request)
      false
    elsif !existing_review && user.reviewed_course?(section.course)
      render(json: { msg: "You've already reviewed this course." }, status: :bad_request)
      false
    elsif review_params.comments.length < 40
      render(json: { msg: "Your review looks a little short. Tell us a bit more about the class!" }, status: :bad_request)
      false
    elsif review_params.comments.gibberish?
      render(json: { msg: "We had trouble understanding your review. Please make sure everything looks correct!" }, status: :bad_request)
      false
    else
      true
    end
  end
end
