# typed: strict
# frozen_string_literal: true

class Admin::ReviewsController < AdminController
  sig { void }
  def initialize
    super
    @reviews = T.let(nil, T.nilable(Review::RelationType))
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
end
