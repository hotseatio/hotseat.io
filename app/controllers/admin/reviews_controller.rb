# typed: strict
# frozen_string_literal: true

class Admin::ReviewsController < AdminController
  sig { void }
  def initialize
    super
    @reviews = T.let(nil, T.nilable(Review::RelationType))
    @review = T.let(nil, T.nilable(Review))
    @author = T.let(nil, T.nilable(User))
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
  end

  class UpdateParams < T::Struct
    const :id, Integer
    const :status, Review::Status
  end

  # PATCH/PUT /admin/review/:id
  sig { void }
  def update
    typed_params = TypedParams[UpdateParams].new.extract!(params)
    @review = Review.find(typed_params.id)

    # TODO: move this to @review.approve! for testability
    if (typed_params.status == Review::Status::Approved) && !@review.approved?
      user = T.must(@review.user)

      user.add_notification_token

      if user.referred_by
        # TODO: this check is incorrect if the new user has multiple unapproved reviews
        is_first_review = user.reviews.size == 1
        user.complete_referral! if is_first_review
      end

      NotifyUserAboutApprovedReviewJob.perform_later(@review)
    elsif typed_params.status == Review::Status::Rejected
      NotifyUserAboutRejectedReviewJob.perform_later(@review)
    end

    @review.typed_status = typed_params.status
    @review.save!

    redirect_to(admin_review_path(@review))
  end
end
