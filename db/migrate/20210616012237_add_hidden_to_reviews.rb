# typed: true
# frozen_string_literal: true

class AddHiddenToReviews < ActiveRecord::Migration[6.1]
  def change
    change_table :reviews, bulk: true do |t|
      t.boolean :hidden, null: false, default: false
    end
  end
end
