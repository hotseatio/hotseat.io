# typed: true
# frozen_string_literal: true

class AddRegistrarListingToInstructor < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table(:instructors, bulk: true) do |t|
        dir.up do
          # Registrar listing is how the instructor(s) are listed in the registrar
          t.string(:registrar_listing, array: true)
          # Make names nullable
          t.change(:first_names, :string, null: true, array: true)
          t.change(:last_names, :string, null: true, array: true)
          t.index(%i[registrar_listing], unique: true)
          t.remove_index(name: 'index_instructors_on_names')
        end

        dir.down do
          t.remove(:registrar_listing)
          t.change(:first_names, :string, null: false, array: true, default: [])
          t.change(:last_names, :string, null: false, array: true, default: [])
          t.index(%i[first_names last_names], unique: true, name: 'index_instructors_on_names')
        end
      end
    end
  end
end
