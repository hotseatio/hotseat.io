# typed: true
# frozen_string_literal: true

class AddRelationshipIdToReviews < ActiveRecord::Migration[6.1]
  def change
    change_table(:reviews, bulk: true) do |t|
      t.references(:relationship)
    end
  end
end
