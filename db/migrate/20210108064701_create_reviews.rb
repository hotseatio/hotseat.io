# typed: true
# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table(:reviews) do |t|
      # Ratings 1-7, 7 being best
      t.integer(:organization)
      t.integer(:clarity)
      t.integer(:difficulty)
      t.integer(:overall)

      t.text(:comments)

      t.timestamps
    end

    change_table(:relationships) do |t|
      t.references(:review, foreign_key: true)
    end
  end
end
