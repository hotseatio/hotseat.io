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

  sig { void }
  def index
    typed_params = TypedParams[IndexParams].new.extract!(params)
    page = typed_params.page

    @reviews = Review.all.where(status: :pending).order(created_at: :desc).page(page)
  end

  class ShowParams < T::Struct
    const :id, Integer
  end

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

  sig { void }
  def update
    typed_params = TypedParams[UpdateParams].new.extract!(params)
    @review = Review.find(typed_params.id)
    user = T.must(@review.user)
    is_first_review = user.reviews.size == 1

    if (typed_params.status == Review::Status::Approved) && !@review.approved?
      user.add_notification_token
      user.complete_referral! if is_first_review && user.referred_by

      NotifyUserAboutApprovedReviewJob.perform_later(@review)
    elsif typed_params.status == Review::Status::Approved
      NotifyUserAboutRejectedReviewJob.perform_later(@review)
    end

    @review.typed_status = typed_params.status
    @review.save!

    redirect_to(admin_review_path(@review))
  end
end
