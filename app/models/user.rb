# typed: strict
# frozen_string_literal: true

require "rotp"

class User < ApplicationRecord
  extend T::Sig
  extend Pay::Attributes::ClassMethods
  include Pay::Attributes::CustomerExtension

  VALID_UCLA_EMAIL_REGEX = T.let(/\A.+@g\.ucla\.edu\z/i, Regexp)
  before_save :save_normalized_phone

  devise :rememberable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]
  pay_customer

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_UCLA_EMAIL_REGEX, message: "must be an @g.ucla.edu email" },
                    uniqueness: true
  validates :notification_token_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :phone, phone: true, allow_blank: true

  has_many :relationships, dependent: :restrict_with_exception
  has_many :sections, through: :relationships
  has_many :courses, through: :sections
  has_many :reviews, through: :relationships
  has_many :notifications, as: :recipient, dependent: :destroy

  belongs_to :referred_by,
             class_name: "User",
             optional: true
  has_many :referred_users,
           class_name: "User",
           foreign_key: :referred_by_id,
           inverse_of: :referred_by,
           dependent: :restrict_with_exception

  before_create :set_referral_code
  validates :referral_code, uniqueness: true

  sig { void }
  def set_referral_code
    # Generate code until we get a unique one
    # (We sholud get a unique code on the first try, second try worst case)
    10.times do
      self.referral_code = SecureRandom.hex(6).downcase
      return unless self.class.exists?(referral_code:)
    end
    raise ActiveRecord::ActiveRecordError, "Could not generate unique referral code"
  end

  # Called when a referral is complete, i.e., a user has signed up and written a review.
  # As a bonus, the user and their referrer get an extra notification token each!
  # This method is idempotent.
  sig { void }
  def complete_referral!
    return unless referral_completed_at.nil? && referred_by

    update(referral_completed_at: Time.zone.now)
    add_notification_token
    T.must(referred_by).add_notification_token
  end

  sig { params(auth: T.untyped, referral_code: T.nilable(String)).returns(User) }
  def self.from_omniauth(auth, referral_code:)
    user = find_by(provider: auth.provider, uid: auth.uid)

    if user.nil?
      user = new(
        provider: auth.provider,
        uid: auth.uid,
      )

      if referral_code.present?
        referring_user = User.find_by(referral_code:)
        user.referred_by = referring_user if referring_user.present?
      end

      user.email = auth.info.email
      user.name = auth.info.name
      user.save

      # Add user to mailing list
      if T.unsafe(Rails.env).production?
        logger.info("Created new user #{user.id}, adding user to Mailchimp mailing list")
        AddNewUserToMailingListJob.perform_later(user)
      end
    else
      user.email = auth.info.email
      user.name = auth.info.name
      user.save
    end

    user
  end

  # Marks a section as being followed by the given user.
  sig { params(section: Section).void }
  def follow(section)
    sections << section unless following?(section)
  end

  # Marks a section as being followed with notifications by the given user.
  sig { params(section: Section).void }
  def subscribe(section)
    follow(section)
    relationship = relationships.find_by(section:)
    relationship&.update(notify: true) if use_notification_token
  end

  # Whether a user is subscribed to a given section.
  sig { params(section: Section).returns(T::Boolean) }
  def subscribed?(section)
    relationship = relationships.find_by(section:)
    relationship&.notify? || false
  end

  # Whether a user is following a given section.
  sig { params(section: Section).returns(T::Boolean) }
  def following?(section)
    sections.include?(section)
  end

  # Stops following a section the user was following.
  sig { params(section: Section).void }
  def unfollow(section)
    relationship = relationships.find_by(section:)
    raise ActiveRecord::RecordNotDestroyed, "Section is reviewed by user, cannot unfollow." if relationship&.review?

    sections.delete(section)
  end

  # Stops subscribing to a section. User will still be following section.
  sig { params(section: Section).returns(T::Boolean) }
  def unsubscribe(section)
    relationship = relationships.find_by(section:)
    if relationship&.notify
      relationship.update(notify: false)
      true
    else
      false
    end
  end

  # Give the user a notification token and saves the new value.
  sig { params(count: Integer).void }
  def add_notification_token(count: 1)
    increment!(
      :notification_token_count,
      count,
      touch: true,
    )
  end

  # Remove a notification token from a user and save the new count.
  # Returns false if the user has no notification tokens.
  sig { returns(T::Boolean) }
  def use_notification_token
    if notification_token_count <= 0
      false
    else
      decrement!(:notification_token_count, touch: true)
      true
    end
  end

  sig { params(term: Term).returns(Integer) }
  def review_count_for_term(term)
    sections.where(term:).size
  end

  # Whether a user has reviewed a given course.
  sig { params(course: Course).returns(T::Boolean) }
  def reviewed_course?(course)
    reviews.joins(:relationship, :section).where("sections.course_id": course).any?
  end

  # Whether a user has reviewed a given section.
  sig { params(section: Section).returns(T::Boolean) }
  def reviewed_section?(section)
    reviews.where("relationships.section_id": section).any?
  end

  sig { returns(T.nilable(String)) }
  def formatted_phone
    User.format_phone(phone)
  end

  # Normalize phone number to E.164 format, e.g., +11234567890
  # https://en.wikipedia.org/wiki/E.164
  sig { params(phone: String).returns(T.nilable(String)) }
  def self.normalize_phone(phone)
    Phonelib.parse(phone).full_e164.presence
  end

  # Format phone number to a human-readable format, e.g., +1 (123) 456-7890
  sig { params(phone: T.nilable(String)).returns(T.nilable(String)) }
  def self.format_phone(phone)
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == "1" # NANP
        "+1 #{parsed_phone.full_national}" # +1 (415) 555-2671;123
      else
        parsed_phone.full_international # +44 20 7183 8750
      end
    formatted.gsub!(";", " x") # +1 (415) 555-2671 x123
    formatted
  end

  sig { void }
  def set_new_otp_secret!
    self.phone_verification_otp_secret = ROTP::Base32.random
  end

  sig { void }
  def delete_otp_secret!
    self.phone_verification_otp_secret = nil
  end

  sig { returns(String) }
  def generate_otp_code
    totp = ROTP::TOTP.new(phone_verification_otp_secret, interval: 10.minutes.to_i)
    totp.now
  end

  sig { params(code: String).returns(T::Boolean) }
  def validate_otp_code(code)
    totp = ROTP::TOTP.new(phone_verification_otp_secret, interval: 10.minutes.to_i)
    totp.verify(code).present?
  end

  private

  sig { void }
  def save_normalized_phone
    self.phone = self.class.normalize_phone(T.must(phone)) if phone.present?
  end
end
