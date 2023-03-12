# typed: true
# frozen_string_literal: true

class AddFirstApprovedAtToReview < ActiveRecord::Migration[7.0]
  def change
    add_column(:reviews, :first_approved_at, :datetime, default: nil)
  end
end
