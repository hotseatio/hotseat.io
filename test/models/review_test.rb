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
      term = create(:term, term: "21S")
      section = create(:section, term:)
      review = create(:review, section:)
      assert_equal("Spring 2021", review.quarter_taken)
    end
  end

  describe "#overall_rating" do
    it "returns the overall rating of the review, scaled to 10 points" do
      review = build(:review, overall: 6)
      assert_in_delta(8.3, review.overall_rating)
    end
  end

  describe "#clarity_rating" do
    it "returns the clarity rating of the review, scaled to 10 points" do
      review = build(:review, clarity: 2)
      assert_in_delta(1.7, review.clarity_rating)
    end
  end

  describe "#organization_rating" do
    it "returns the organization rating of the review, scaled to 10 points" do
      review = build(:review, organization: 7)
      assert_equal(10, review.organization_rating)
    end
  end

  describe "#ratings" do
    it "returns the ratings as an array of hashes" do
      review = build(:review,
                     clarity: 2,
                     organization: 4,
                     weekly_time: "10-15",
                     overall: 5)
      assert_equal(
        [
          {
            label: "Clarity",
            value: 1.7,
          },
          {
            label: "Organization",
            value: 5,
          },
          {
            label: "Time",
            value: "10-15",
          },
          {
            label: "Overall",
            value: 6.7,
          },
        ],
        review.ratings,
      )
    end
  end

  describe "#course_details" do
    it "returns details about the course from the review as an array of hashes" do
      review = build(:review,
                     has_group_project: true,
                     midterm_count: 2,
                     requires_attendance: false,
                     final: "10th",
                     reccomend_textbook: false)
      assert_equal(
        [
          {
            label: :has_group_project,
            value: true,
          },
          {
            label: :midterm_count,
            value: 2,
          },
          {
            label: :requires_attendance,
            value: false,
          },
          {
            label: :final,
            value: "10th",
          },
          {
            label: :reccomend_textbook,
            value: false,
          },
        ],
        review.course_details,
      )
    end
  end
end
