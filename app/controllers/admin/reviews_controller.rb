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

    @reviews = Review.all.order(created_at: :desc).page(page)
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

  class ApproveParams < T::Struct
    const :id, Integer
  end

  sig { void }
  def approve
    typed_params = TypedParams[ShowParams].new.extract!(params)
    @review = Review.find(typed_params.id)
    user = T.must(@review.user)

    @review.approved!
    user.add_notification_token

    # Notify about approval
  end

  class RejectParams < T::Struct
    const :id, Integer
  end

  sig { void }
  def reject
    typed_params = TypedParams[ShowParams].new.extract!(params)
    @review = Review.find(typed_params.id)
    @review.rejected!
    # Notify about rejection
  end
end
