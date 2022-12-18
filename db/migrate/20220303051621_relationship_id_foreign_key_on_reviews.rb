# typed: true
# frozen_string_literal: true

class RelationshipIdForeignKeyOnReviews < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key(:reviews, :relationships)
    remove_reference(:relationships, :review, index: true, foreign_key: true)
  end
end
