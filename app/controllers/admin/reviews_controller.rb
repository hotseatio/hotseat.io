# typed: strict
# frozen_string_literal: true

class Admin::ReviewsController < AdminController
  sig { void }
  def initialize
    super
    @reviews = T.let(nil, T.nilable(ActiveRecord::Relation))
    @review = T.let(nil, T.nilable(Review))
    @author = T.let(nil, T.nilable(User))
  end

  class IndexParams < T::Struct
    const :page, T.nilable(Integer)
  end

  # GET /admin/reviews
  sig { void }
  def index
    typed_params = TypedParams.extract!(IndexParams, params)
    page = typed_params.page

    @reviews = Review.all.where(status: :pending).order(updated_at: :desc).page(page)
  end

  class ShowParams < T::Struct
    const :id, Integer
  end

  # GET /admin/review/:id
  sig { void }
  def show
    typed_params = TypedParams.extract!(ShowParams, params)
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
    typed_params = TypedParams.extract!(UpdateParams, params)
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
end
