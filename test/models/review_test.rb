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

  describe "review statuses" do
    describe "#approve!" do
      before do
        create_current_term
      end

      it "gives a notification token to the reviewer" do
        T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "pending")

        assert_predicate(review, :pending?)
        assert_not(review.first_approved_at)
        assert_equal(0, reviewer.notification_token_count)
        assert(review.approve!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(1, reviewer.notification_token_count)
        assert(review.first_approved_at)
      end

      it "is idempotent; it returns false for an approved review" do
        T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).never
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "approved")

        assert_predicate(review, :approved?)
        assert_equal(0, reviewer.notification_token_count)
        assert_not(review.first_approved_at)
        assert_not(review.approve!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(0, reviewer.notification_token_count)
        assert_not(review.first_approved_at)
      end

      it "gives two notification tokens to a referred reviewer for the first time" do
        T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
        referrer = create(:user, notification_token_count: 0)
        reviewer = create(:user, notification_token_count: 0, referred_by: referrer)
        review = create(:review, user: reviewer, status: "pending")

        assert_predicate(review, :pending?)
        assert_equal(0, reviewer.notification_token_count)
        assert_not(review.first_approved_at)
        assert(review.approve!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(2, reviewer.notification_token_count)
        assert_equal(1, referrer.notification_token_count)
        assert(review.first_approved_at)
      end

      it "gives one notification token to a referred reviewer for the second time" do
        T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
        referrer = create(:user, notification_token_count: 0)
        reviewer = create(:user, notification_token_count: 0, referred_by: referrer, referral_completed_at: Time.zone.now)
        review = create(:review, user: reviewer, status: "pending")

        assert_predicate(review, :pending?)
        assert_equal(0, reviewer.notification_token_count)
        assert_not(review.first_approved_at)
        assert(review.approve!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(1, reviewer.notification_token_count)
        assert_equal(0, referrer.notification_token_count)
        assert(review.first_approved_at)
      end

      it "does not give a notification token to a review that's been edited" do
        first_approved_at = Time.zone.now
        T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).never
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "pending", first_approved_at:)

        assert(review.approve!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(0, reviewer.notification_token_count)
        assert_equal(first_approved_at, review.first_approved_at)
      end
    end

    describe "#reject!" do
      it "rejects the review and sends a notification to the user" do
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "pending")
        expect_notification_to_be_sent(ReviewRejectedNotification, reviewer, review:, rejection_reason: nil)

        assert(review.reject!)
        review.reload

        assert_predicate(review, :rejected?)
        assert_equal(0, reviewer.notification_token_count)
      end

      it "sends a rejection reason if provided" do
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "pending")
        rejection_reason = "Review is for the wrong professor"
        expect_notification_to_be_sent(ReviewRejectedNotification, reviewer, review:, rejection_reason:)

        assert(review.reject!(rejection_reason))
        review.reload

        assert_predicate(review, :rejected?)
        assert_equal(0, reviewer.notification_token_count)
      end

      it "does not reject the review if the review is rejected" do
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "rejected")
        expect_notification_not_to_be_sent(ReviewRejectedNotification)

        assert_not(review.reject!)
        review.reload

        assert_predicate(review, :rejected?)
        assert_equal(0, reviewer.notification_token_count)
      end

      it "does not reject the review if the review is approved" do
        T.unsafe(NotifyUserAboutRejectedReviewJob).expects(:perform_later).never

        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "approved")
        expect_notification_not_to_be_sent(ReviewRejectedNotification)

        assert_not(review.reject!)
        review.reload

        assert_predicate(review, :approved?)
        assert_equal(0, reviewer.notification_token_count)
      end
    end

    describe "#set_pending!" do
      it "sets a review as pending" do
        reviewer = create(:user, notification_token_count: 0)
        review = create(:review, user: reviewer, status: "approved")
        assert(review.set_pending!)
        assert_predicate(review, :pending?)
      end
    end
  end
end
