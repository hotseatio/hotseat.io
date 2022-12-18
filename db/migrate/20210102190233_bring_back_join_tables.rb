# typed: strict
# frozen_string_literal: true

class BringBackJoinTables < ActiveRecord::Migration[6.1]
  extend T::Sig

  sig { void }
  def change
    # These tables are only used by the lambda functions to reduce the number of subject areas/courses that need to be checked.
    create_join_table(:courses, :terms, column_options: { foreign_key: true }) do |t|
      t.index(%i[course_id term_id], unique: true)
      t.index(:course_id)
      t.index(:term_id)
    end

    create_join_table(:subject_areas, :terms, column_options: { foreign_key: true }) do |t|
      t.index(%i[subject_area_id term_id], unique: true)
      t.index(:subject_area_id)
      t.index(:term_id)
    end
  end
end
