# typed: strict
# frozen_string_literal: true

class Admin::ReviewsController < AdminController
  sig { void }
  def initialize
    super
    @reviews = T.let(nil, T.nilable(Review::RelationType))
    @review = T.let(nil, T.nilable(Review))
    @author = T.let(nil, T.nilable(User))
    @section = T.let(nil, T.nilable(Section))
  end

  class IndexParams < T::Struct
    const :page, T.nilable(Integer)
  end

  # GET /admin/reviews
  sig { void }
  def index
    typed_params = TypedParams[IndexParams].new.extract!(params)
    page = typed_params.page

    @reviews = Review.all.where(status: :pending).order(updated_at: :desc).page(page)
  end

  class ShowParams < T::Struct
    const :id, Integer
  end

  # GET /admin/review/:id
  sig { void }
  def show
    typed_params = TypedParams[ShowParams].new.extract!(params)
    @review = Review.find(typed_params.id)
    @author = @review.user
    @section = T.must(@review.section)
  end

  class UpdateParams < T::Struct
    const :id, Integer
    const :status, Review::Status
  end

  # PATCH/PUT /admin/review/:id
  sig { void }
  def update
    typed_params = TypedParams[UpdateParams].new.extract!(params)
    status = typed_params.status
    @review = Review.find(typed_params.id)

    case status
    when Review::Status::Approved
      @review.approve!
    when Review::Status::Rejected
      @review.reject!
    when Review::Status::Pending
      @review.set_pending!
    else
      T.absurd(status)
    end

    redirect_to(admin_review_path(@review))
  end

  class UpdateAllParams < T::Struct
    const :status, Review::Status
  end

  # PATCH/PUT /admin/reviews/all
  sig { void }
  def update_all_pending
    Rails.logger.debug("NATHAN HELLO")
    typed_params = TypedParams[UpdateAllParams].new.extract!(params)

    pending_reviews = T.let(T.unsafe(Review.all.where(status: :pending)).to_a, T::Array[Review])
    pending_reviews.map do |review|
      update_review(review, typed_params.status)
    end

    redirect_to(admin_reviews_path)
  end

  private

  sig { params(review: Review, status: Review::Status).returns(Review) }
  def update_review(review, status)
    user = T.must(review.user)
    is_first_review = user.reviews.size == 1

    if (status == Review::Status::Approved) && !review.approved?
      user.add_notification_token
      user.complete_referral! if is_first_review && user.referred_by

      NotifyUserAboutApprovedReviewJob.perform_later(review)
    elsif status == Review::Status::Rejected
      NotifyUserAboutRejectedReviewJob.perform_later(review)
    end

    review.typed_status = status
    review.save!

    review
  end
end
