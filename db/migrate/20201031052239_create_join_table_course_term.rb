# typed: true
# frozen_string_literal: true

class CreateJoinTableCourseTerm < ActiveRecord::Migration[6.0]
  def change
    create_join_table :courses, :terms do |t|
      t.index %i[course_id term_id], unique: true
      # t.index [:term_id, :course_id]
    end

    add_foreign_key :courses_terms, :courses
    add_foreign_key :courses_terms, :terms
  end
end
