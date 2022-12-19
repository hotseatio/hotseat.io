# typed: true
# frozen_string_literal: true

class AddAdditionalFieldsToSection < ActiveRecord::Migration[6.0]
  def change
    # ACT -> Activity
    # CLI -> Clinic
    # DIS -> Discussion
    # FLD -> Fieldwork
    # LAB -> Laboratory
    # LEC -> Lecture
    # REC -> Recitation
    # RGP -> Research Group
    # SEM -> Seminar
    # STU -> Studio
    # TUT -> Tutorial
    # Ref: https://ucla.app.box.com/s/v9vf0js91wf73olvyx0xr1fq7hm7vgvh

    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE section_format AS ENUM ('ACT', 'CLI', 'DIS', 'FLD', 'LAB', 'LEC', 'REC', 'RGP', 'SEM', 'STU', 'TUT');
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE section_format;
        SQL
      end
    end

    change_table(:sections, bulk: true) do |t|
      t.column(:format, :section_format)
      t.integer(:index)
      t.string(:website)
      t.datetime(:final_start)
      t.datetime(:final_end)
    end
  end
end
