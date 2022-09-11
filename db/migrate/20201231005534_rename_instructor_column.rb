# typed: strict
# frozen_string_literal: true

class RenameInstructorColumn < ActiveRecord::Migration[6.1]
  extend T::Sig

  sig { void }
  def change
    # Rename to registrar_instructors to not interfere with the instructors table/model.
    rename_column :sections, :instructors, :registrar_instructors

    drop_join_table :courses, :terms
    drop_join_table :subject_areas, :terms
  end
end
