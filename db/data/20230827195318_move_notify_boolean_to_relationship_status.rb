# typed: true
# frozen_string_literal: true

class MoveNotifyBooleanToRelationshipStatus < ActiveRecord::Migration[7.0]
  def up
    Relationship.all.find_each do |relationship|
      # We have no way of telling whether a user enrolled in a section -- that's a new state!
      relationship.stored_status = if relationship.notify
                                     :subscribed
                                   else
                                     :planned
                                   end
      relationship.save!
    end
  end

  def down
    Relationship.update_all(stored_status: nil)
  end
end
