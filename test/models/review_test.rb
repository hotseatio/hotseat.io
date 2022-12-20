# typed: strict
# frozen_string_literal: true

require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  describe "validations" do
    it "accepts organization ratings only between 1 and 7" do
      valid_review = build(:review, organization: 5)
      assert_predicate(valid_review, :valid?)

      invalid_review = build(:review, organization: -11)
      assert_not(invalid_review.valid?)
    end

    it "accepts clarity ratings only between 1 and 7" do
      valid_review = build(:review, clarity: 1)
      assert_predicate(valid_review, :valid?)

      invalid_review = build(:review, clarity: 100)
      assert_not(invalid_review.valid?)
    end

    it "accepts overall ratings only between 1 and 7" do
      valid_review = build(:review, overall: 7)
      assert_predicate(valid_review, :valid?)

      invalid_review = build(:review, overall: 8)
      assert_not(invalid_review.valid?)
    end
  end

  describe "#quarter_taken" do
    it "returns the quarter that the review is for" do
      term = T.let(create_current_term, Term)
      section = create(:section, term:)
      review = build(:review, section:)
      assert_nil(review.quarter_taken)
    end
  end
end
