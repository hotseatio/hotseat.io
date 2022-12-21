# typed: true
# frozen_string_literal: true

class CreateEnrollmentAppointments < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE enrollment_appointment_pass AS ENUM ('graduate', 'priority', 'first', 'second');
          CREATE TYPE enrollment_appointment_standing AS ENUM ('graduating_senior', 'almost_graduating_senior', 'new', 'readmitted', 'visiting', 'senior', 'junior', 'sophomore', 'freshman', 'joint_graduate', 'graduate');
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE enrollment_appointment_standing;
          DROP TYPE enrollment_appointment_pass;
        SQL
      end
    end

    create_table(:enrollment_appointments) do |t|
      t.references(:term, null: false, foreign_key: true)
      t.column(:pass, :enrollment_appointment_pass, null: false)
      t.column(:standing, :enrollment_appointment_standing, null: true)
      t.datetime(:first, null: false)
      t.datetime(:last, null: false)

      t.index(%i[term_id pass standing], unique: true)
      t.index(%i[term_id pass], unique: true, where: "standing IS NULL")

      t.timestamps
    end
  end
end
