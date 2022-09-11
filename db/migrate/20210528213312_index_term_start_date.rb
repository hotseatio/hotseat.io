# typed: true
# frozen_string_literal: true

class IndexTermStartDate < ActiveRecord::Migration[6.1]
  def change
    add_index :terms, :start_date
  end
end
