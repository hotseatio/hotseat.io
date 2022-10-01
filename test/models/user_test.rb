# typed: strict
# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'always has a name' do
    valid_user = build :user, name: 'Nathan Smith'
    assert_equal true, valid_user.valid?

    invalid_user = build :user, name: ''
    assert_equal false, invalid_user.valid?
  end

  it 'always has an email' do
    valid_user = build :user, email: 'natedub@g.ucla.edu'
    assert_equal true, valid_user.valid?

    invalid_user = build :user, name: ''
    assert_equal false, invalid_user.valid?
  end

  it 'has a name that is not too long' do
    user = build :user, name: 'Nathan' * 10
    assert_equal false, user.valid?
  end

  it 'has an email that is not too long' do
    user = build :user, email: 'nathan.smith@ucla.edu' * 1500
    assert_equal false, user.valid?
  end

  it 'can only have a ucla email' do
    valid_user = build :user, email: 'nathansmith@g.ucla.edu'
    assert_equal true, valid_user.valid?

    invalid_user = build :user, email: 'nathansmith@gmail.com'
    assert_equal false, invalid_user.valid?
  end

  describe 'unfollow' do
    let(:term) { create :term }
    let(:user) { create :user }
    let(:sections) do
      sections = create_list :section, 2, term: term
      create :relationship, :with_review, user: user, section: sections.first
      create :relationship, user: user, section: sections.second
      sections
    end

    it 'removes a relationship' do
      user.unfollow sections.second
      expect(user.sections).to match_array [sections.first]
    end

    it 'does not remove a relationship when it is reviewed' do
      expect { user.unfollow sections.first }.to raise_error(ActiveRecord::RecordNotDestroyed)
      expect(user.sections).to match_array sections
    end
  end

  describe 'add_notification_token' do
    it 'adds a single notification token to a user' do
      user = build :user, notification_token_count: 1
      user.add_notification_token
      assert_equal 2, user.notification_token_count
    end
  end

  describe 'use_notification_token' do
    it 'removes a single notification token from a user and returns true' do
      user = build :user, notification_token_count: 3
      assert_equal  true, user.use_notification_token
      assert_equal  2, user.notification_token_count
    end

    it 'returns false if a user has no notification tokens that can be used' do
      user = build :user, notification_token_count: 0
      assert_equal  false, user.use_notification_token
      assert_equal  0, user.notification_token_count
    end
  end

  describe 'review_count_for_term' do
    it 'returns 0 if a user has not written any reviews' do
      term = build :term
      user = build :user
      assert_equal  0, user.review_count_for_term(term)
    end

    it 'returns a number if a user has written reviews for sections during that term' do
      term = create :term
      user = create :user
      sections = create_list :section, 2, term: term
      create :relationship, :with_review, user: user, section: sections.first
      create :relationship, :with_review, user: user, section: sections.second

      assert_equal  2, user.review_count_for_term(term)
    end
  end

  describe 'reviewed_course?' do
    it 'returns true if the user has reviewed the course' do
      user = create :user
      course = create :course
      section = create :section, course: course
      create :relationship, :with_review, user: user, section: section

      assert_equal true, user.reviewed_course?(course)
    end

    it 'returns false if the user has not reviewed the course' do
      user = create :user
      course = create :course
      section = create :section, course: course
      create :relationship, user: user, section: section

      assert_equal false, user.reviewed_course?(course)
    end
  end

  describe 'formatted_phone' do
    it 'returns a users phone number in a human-readable format' do
      user = create :user, phone: '4155720407'
      assert_equal '+1 (415) 572-0407', user.formatted_phone
    end
  end

  describe '#set_referral_code' do
    it 'generates a unique referral code' do
      user = build :user
      user.set_referral_code
      assert_not_nil user.referral_code
    end

    it 'raises an error if it cannot generate a referral code for some reason' do
      referral_code = 'test-code'
      allow(SecureRandom).to receive(:hex) { referral_code }
      create :user, referral_code: referral_code
      user = build :user
      expect { user.set_referral_code }.to raise_error(ActiveRecord::ActiveRecordError)
    end
  end
end
