# typed: true
# frozen_string_literal: true

class AddStatusToReviews < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL.squish
      CREATE TYPE review_status AS ENUM ('pending', 'approved', 'rejected');
    SQL
    add_column(:reviews, :status, :review_status, null: false, default: "pending")
    add_index(:reviews, :status)
  end

  def down
    remove_index(:reviews, :status)
    remove_column(:reviews, :status)
    execute <<-SQL.squish
      DROP TYPE review_status;
    SQL
  end
end
