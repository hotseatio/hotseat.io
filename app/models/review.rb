# typed: strict
# frozen_string_literal: true

class Review < ApplicationRecord
  extend T::Sig

  belongs_to :relationship
  has_one :user, through: :relationship
  has_one :section, through: :relationship
  has_one :course, through: :section
  has_one :instructor, through: :section
  has_one :term, through: :section

  validates :organization, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }, allow_nil: false
  validates :clarity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }, allow_nil: false
  validates :overall, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }, allow_nil: false

  before_validation :cleanup_review_comments

  delegate :location_type, to: :section

  enum weekly_time: {
    zero_to_five: "0-5",
    five_to_ten: "5-10",
    ten_to_fifteen: "10-15",
    fifteen_to_twenty: "15-20",
    twenty_plus: "20+",
  }, _suffix: :hours

  enum final: {
    no_final: "none",
    tenth_week: "10th",
    finals_week: "finals",
  }

  enum grade: {
    a_plus: "A+",
    a: "A",
    a_minus: "A-",
    b_plus: "B+",
    b: "B",
    b_minus: "B-",
    c_plus: "C+",
    c: "C",
    c_minus: "C-",
    d_plus: "D+",
    d: "D",
    d_minus: "D-",
    f: "F",
    pass: "P",
    no_pass: "NP",
  }

  enum status: {
    pending: "pending",
    approved: "approved",
    rejected: "rejected",
  }

  scope :viewable, -> { where(hidden: false, status: "approved") }
  scope :has_comment, -> { where.not(comments: "") }

  sig do
    params(reviews: ActiveRecord::Relation)
      .returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]])
  end
  def self.course_details(reviews)
    # Take advantage of Postgres' `mode()` functionality
    has_group_project = reviews.where.not(has_group_project: nil)
                               .pick(Arel.sql("mode() within group (order by has_group_project)"))
    final = reviews.where.not(final: nil)
                   .pick(Arel.sql("mode() within group (order by final)"))
    requires_attendance = reviews.where.not(requires_attendance: nil)
                                 .pick(Arel.sql("mode() within group (order by requires_attendance)"))
    midterm_count = reviews.where.not(midterm_count: nil)
                           .pick(Arel.sql("mode() within group (order by midterm_count)"))
    textbook_reccomendations = reviews.where.not(reccomend_textbook: nil)
                                      .group(:reccomend_textbook).count
    textbook_reccomend_percentage = (textbook_reccomendations[true].to_f / textbook_reccomendations.values.sum)

    details = []

    unless has_group_project.nil?
      details.push({
                     label: :has_group_project,
                     value: ActiveModel::Type::Boolean.new.cast(has_group_project),
                   })
    end
    unless requires_attendance.nil?
      details.push({
                     label: :requires_attendance,
                     value: ActiveModel::Type::Boolean.new.cast(requires_attendance),
                   })
    end
    unless midterm_count.nil?
      details.push({
                     label: :midterm_count,
                     value: midterm_count.to_i,
                   })
    end
    unless final.nil?
      details.push({
                     label: :final,
                     value: final,
                   })
    end
    unless textbook_reccomend_percentage.nan?
      details.push({
                     label: :reccomend_textbook,
                     value: textbook_reccomend_percentage * 100,
                   })
    end

    details
  end

  sig do
    params(reviews: ActiveRecord::Relation)
      .returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]])
  end
  def self.average_ratings(reviews)
    overall, clarity, organization = reviews.pick(
      "AVG(overall)",
      "AVG(clarity)",
      "AVG(organization)",
    )
    weekly_time = reviews.where.not(weekly_time: nil)
                         .pick(Arel.sql("mode() within group (order by weekly_time)"))

    [
      {
        label: "Clarity",
        value: scale_to_ten_points(clarity),
      },
      {
        label: "Organization",
        value: scale_to_ten_points(organization),
      },
      {
        label: "Time",
        value: weekly_time,
      },
      {
        label: "Overall",
        value: scale_to_ten_points(overall),
      },
    ]
  end

  sig { params(rating: T.nilable(BigDecimal)).returns(T.nilable(BigDecimal)) }
  def self.scale_to_ten_points(rating)
    return nil if rating.nil?

    (10.0 * (rating - 1) / (7 - 1)).round(1)
  end

  sig { returns(T.nilable(String)) }
  def quarter_taken
    term&.readable
  end

  sig { returns(T.nilable(BigDecimal)) }
  def overall_rating
    Review.scale_to_ten_points(BigDecimal(T.must(overall))) if overall
  end

  sig { returns(T.nilable(BigDecimal)) }
  def clarity_rating
    Review.scale_to_ten_points(BigDecimal(T.must(clarity))) if clarity
  end

  sig { returns(T.nilable(BigDecimal)) }
  def organization_rating
    Review.scale_to_ten_points(BigDecimal(T.must(organization))) if organization
  end

  sig { returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]]) }
  def ratings
    [
      {
        label: "Clarity",
        value: clarity_rating,
      },
      {
        label: "Organization",
        value: organization_rating,
      },
      {
        label: "Time",
        value: read_attribute_before_type_cast(:weekly_time),
      },
      {
        label: "Overall",
        value: overall_rating,
      },
    ]
  end

  sig { returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]]) }
  def course_details
    [
      {
        label: :has_group_project,
        value: has_group_project,
      },
      {
        label: :midterm_count,
        value: midterm_count,
      },
      {
        label: :requires_attendance,
        value: requires_attendance,
      },
      {
        label: :final,
        value: read_attribute_before_type_cast(:final),
      },
      {
        label: :reccomend_textbook,
        value: reccomend_textbook,
      },
    ]
  end

  # Approve a review and provide the review with a notification token if applicable.
  # This method is idempotent.
  sig { returns(T::Boolean) }
  def approve!
    # No need to approve again
    return false if approved?

    # Don't given tokens if the review has been approved before.
    # example: approved review is edited later.
    unless first_approved_at
      T.must(user).complete_referral!
      T.must(user).add_notification_token
      update(first_approved_at: Time.zone.now)
      NotifyUserAboutApprovedReviewJob.perform_later(self)
    end

    approved!

    true
  end

  # Reject the review.
  # This method is idempotent.
  sig { returns(T::Boolean) }
  def reject!
    # Can't reject after a review is approved
    return false if approved?
    # No point in rejecting if already rejected
    return false if rejected?

    NotifyUserAboutRejectedReviewJob.perform_later(self)
    rejected!
    save!

    true
  end

  # Set the review as pending.
  sig { returns(T::Boolean) }
  def set_pending!
    pending!
    save!

    true
  end

  private

  sig { void }
  def cleanup_review_comments
    comments&.strip!
  end
end
