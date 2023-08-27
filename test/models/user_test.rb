# typed: strict
# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  it "always has a name" do
    valid_user = build(:user, name: "Nathan Smith")
    assert_predicate valid_user, :valid?

    invalid_user = build(:user, name: "")
    assert_not invalid_user.valid?
  end

  it "always has an email" do
    valid_user = build(:user, email: "natedub@g.ucla.edu")
    assert_predicate valid_user, :valid?

    invalid_user = build(:user, name: "")
    assert_not invalid_user.valid?
  end

  it "has a name that is not too long" do
    user = build(:user, name: "Nathan" * 10)
    assert_not user.valid?
  end

  it "has an email that is not too long" do
    user = build(:user, email: "nathan.smith@ucla.edu" * 1500)
    assert_not user.valid?
  end

  it "can only have a ucla email" do
    valid_user = build(:user, email: "nathansmith@g.ucla.edu")
    assert_predicate valid_user, :valid?

    invalid_user = build(:user, email: "nathansmith@gmail.com")
    assert_not invalid_user.valid?
  end

  describe "#follow_section" do
    it "adds a section to a user's sections" do
      user = T.let(create(:user), User)
      section = T.let(create(:section), Section)

      assert_not_includes(user.sections, section)
      user.follow_section(section)
      assert_includes(user.sections, section)
    end

    it "does nothing if a section is already followed" do
      user = T.let(create(:user), User)
      section = T.let(create(:section), Section)
      create(:relationship, section:, user:)

      assert_includes(user.sections, section)
      user.follow_section(section)
      assert_includes(user.sections, section)
    end
  end

  describe "#subscribe_to_section" do
    it "subscribes a user to a section they follow" do
      # TODO: implement
    end

    it "follows a section (if not followed) and sets the status to subscribed" do
      # TODO: implement
    end

    it "can move an enrolled section by to subscribed" do
      # TODO: implement
    end
  end

  describe "#enroll_in_section" do
    it "marks a subscription a user is following to enrolled" do
      # TODO: implement
    end

    it "marks a subscription a user has subscribed to as enrolled" do
      # TODO: implement
    end

    it "follows and enrolls in a section a user does not follow" do
      # TODO: implement
    end
  end

  describe "#subscribed_to_section?" do
    it "returns true when a user is subscribed to the section" do
      # TODO: implement
    end

    it "returns false if the user is not subscribed to the section" do
      # TODO: implement
    end
  end

  describe "#unfollow" do
    before do
      @term = T.let(create(:term), Term)
      @user = T.let(create(:user), User)
      @sections = T.let(create_list(:section, 2, term: @term), T::Array[Section])
      create(:relationship, :with_review, user: @user, section: @sections.first)
      create(:relationship, user: @user, section: @sections.second)
    end

    it "removes a relationship" do
      @user.unfollow(T.must(@sections.second))
      assert_equal(1, @user.sections.size)
      assert_includes(@user.sections, @sections.first)
      assert_not_includes(@user.sections, @sections.second)
    end

    it "does not remove a relationship when it is reviewed" do
      assert_raises(ActiveRecord::RecordNotDestroyed) { @user.unfollow(T.must(@sections.first)) }
      assert_equal(2, @user.sections.size)
      assert_includes(@user.sections, @sections.first)
    end
  end

  describe "#add_notification_token" do
    it "adds a single notification token to a user" do
      user = build(:user, notification_token_count: 1)
      user.add_notification_token
      assert_equal 2, user.notification_token_count
    end
  end

  describe "use_notification_token" do
    it "removes a single notification token from a user and returns true" do
      user = build(:user, notification_token_count: 3)
      assert user.use_notification_token
      assert_equal 2, user.notification_token_count
    end

    it "returns false if a user has no notification tokens that can be used" do
      user = build(:user, notification_token_count: 0)
      assert_not user.use_notification_token
      assert_equal 0, user.notification_token_count
    end
  end

  describe "review_count_for_term" do
    it "returns 0 if a user has not written any reviews" do
      term = build(:term)
      user = build(:user)
      assert_equal 0, user.review_count_for_term(term)
    end

    it "returns a number if a user has written reviews for sections during that term" do
      term = create(:term)
      user = create(:user)
      sections = create_list(:section, 2, term:)
      create(:relationship, :with_review, user:, section: sections.first)
      create(:relationship, :with_review, user:, section: sections.second)

      assert_equal 2, user.review_count_for_term(term)
    end
  end

  describe "reviewed_course?" do
    it "returns true if the user has reviewed the course" do
      user = create(:user)
      course = create(:course)
      section = create(:section, course:)
      create(:relationship, :with_review, user:, section:)

      assert user.reviewed_course?(course)
    end

    it "returns false if the user has not reviewed the course" do
      user = create(:user)
      course = create(:course)
      section = create(:section, course:)
      create(:relationship, user:, section:)

      assert_not user.reviewed_course?(course)
    end
  end

  describe "formatted_phone" do
    it "returns a users phone number in a human-readable format" do
      user = create(:user, phone: "4155720407")
      assert_equal "+1 (415) 572-0407", user.formatted_phone
    end
  end

  describe "referral codes" do
    describe "#set_referral_code" do
      it "generates a unique referral code" do
        user = build(:user)
        user.set_referral_code
        assert_not_nil user.referral_code
      end

      it "raises an error if it cannot generate a referral code for some reason" do
        referral_code = "test-code"
        T.unsafe(SecureRandom).stubs(:hex).returns(referral_code)
        create(:user, referral_code:)
        user = build(:user)
        assert_raises(ActiveRecord::ActiveRecordError) { user.set_referral_code }
      end
    end
  end

  describe "login/out functionality" do
    describe "#from_omniauth" do
      it "creates a new user if one does not exist" do
        payload = User::AuthenticationPayload.new(
          provider: "google_oauth2",
          uid: "100000000000000000000",
          name: "Nathan Smith",
          email: "nathan@g.ucla.edu",
        )
        user = User.from_auth_payload(payload, referral_code: nil)

        assert_not_nil(user)
        assert_equal(payload.provider, user.provider)
        assert_equal(payload.uid, user.uid)
        assert_equal(payload.name, user.name)
        assert_equal(payload.email, user.email)
        assert_nil(user.referred_by)
        assert(user.subscribed?("announcements"))
      end

      it "logs a user in if a user does exist" do
        payload = User::AuthenticationPayload.new(
          provider: "google_oauth2",
          uid: "100000000000000000000",
          name: "Nathan Smith",
          email: "nathan@g.ucla.edu",
        )
        user = create(
          :user,
          email: payload.email,
          name: payload.name,
          provider: payload.provider,
          uid: payload.uid,
        )
        user_from_payload = User.from_auth_payload(payload, referral_code: nil)

        assert_not_nil(user_from_payload)
        assert_equal(payload.provider, user.provider)
        assert_equal(payload.uid, user.uid)
        assert_equal(payload.name, user.name)
        assert_equal(payload.email, user.email)
        assert_equal(user.id, user_from_payload.id)
        assert_nil(user.referred_by)
        assert_not(user.subscribed?("announcements"))
      end

      it "sets the referred by code if a user was referred" do
        referring_user = create(:user)
        payload = User::AuthenticationPayload.new(
          provider: "google_oauth2",
          uid: "100000000000000000000",
          name: "Nathan Smith",
          email: "nathan@g.ucla.edu",
        )
        user = User.from_auth_payload(payload, referral_code: referring_user.referral_code)

        assert_not_nil(user)
        assert_equal(payload.provider, user.provider)
        assert_equal(payload.uid, user.uid)
        assert_equal(payload.name, user.name)
        assert_equal(payload.email, user.email)
        assert_equal(referring_user, user.referred_by)
        assert(user.subscribed?("announcements"))
      end
    end
  end

  describe "#unsubscribe_to_section" do
    it "marks a relationship as notify=false" do
      term = T.let(create(:term), Term)
      user = T.let(create(:user), User)
      section = T.let(create(:section, term:), Section)
      relationship = create(:relationship, user:, section:, notify: true)

      assert(user.unsubscribe_to_section(section))

      relationship.reload
      assert_not(relationship.notify)
    end

    it "returns false if the relationship didn't have notify set" do
      term = T.let(create(:term), Term)
      user = T.let(create(:user), User)
      section = T.let(create(:section, term:), Section)
      create(:relationship, user:, section:, notify: false)

      assert_not(user.unsubscribe_to_section(section))
    end

    it "returns false if there is no relationship" do
      term = T.let(create(:term), Term)
      user = T.let(create(:user), User)
      section = T.let(create(:section, term:), Section)

      assert_not(user.unsubscribe_to_section(section))
    end
  end

  describe "phone verification otp codes" do
    describe "#set_new_otp_secret!" do
      it "sets the 'phone_verification_otp_secret' property" do
        user = T.let(build(:user), User)

        assert_nil user.phone_verification_otp_secret
        user.set_new_otp_secret!
        assert_not_nil user.phone_verification_otp_secret
      end
    end

    describe "#delete_otp_secret!" do
      it "unsets the 'phone_verification_otp_secret' property" do
        user = T.let(build(:user, phone_verification_otp_secret: ROTP::Base32.random), User)

        assert_not_nil user.phone_verification_otp_secret
        user.delete_otp_secret!
        assert_nil user.phone_verification_otp_secret
      end
    end

    describe "#generate_otp_code" do
      it "generates a new otp code using the secret" do
        user = T.let(build(:user, phone_verification_otp_secret: ROTP::Base32.random), User)
        assert_equal 6, user.generate_otp_code.length
      end
    end

    describe "#validate_otp_code" do
      it "returns true if the otp code is valid" do
        user = T.let(build(:user, phone_verification_otp_secret: ROTP::Base32.random), User)
        valid_code = user.generate_otp_code
        assert user.validate_otp_code(valid_code)
      end

      it "returns false if the otp code is invalid" do
        user = T.let(build(:user, phone_verification_otp_secret: ROTP::Base32.random), User)
        assert_not user.validate_otp_code("111111")
      end
    end
  end
end
