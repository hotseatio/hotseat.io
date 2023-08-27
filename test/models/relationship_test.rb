# typed: strict
# frozen_string_literal: true

require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  describe "#status" do
    # it "does something"
  end

  describe "reviewed?" do
    it "returns true if the relationship has a review" do
      relationship = create(:relationship, :with_review)
      assert_predicate(relationship, :reviewed?)
    end

    it "returns false if the relationship does not have a review" do
      relationship = create(:relationship)
      assert_not_predicate(relationship, :reviewed?)
    end
  end
end
