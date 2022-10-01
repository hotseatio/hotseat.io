# typed: strict
# frozen_string_literal: true

class Relationship < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :section
  has_one :review, dependent: :restrict_with_exception

  sig { returns(T::Boolean) }
  def review?
    review.present?
  end
end
