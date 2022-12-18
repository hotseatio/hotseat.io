# typed: true
# frozen_string_literal: true

class CreateJoinTableTermSubjectArea < ActiveRecord::Migration[6.0]
  def change
    create_join_table(:subject_areas, :terms, column_options: { foreign_key: true }) do |t|
      t.index(%i[subject_area_id term_id], unique: true)
      t.index(:subject_area_id)
      t.index(:term_id)
    end
  end
end
