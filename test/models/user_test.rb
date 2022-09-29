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

  # it 'always has an email' do
  #   valid_user = build :user, email: 'natedub@g.ucla.edu'
  #   expect(valid_user.valid?).to be true

  #   invalid_user = build :user, name: ''
  #   expect(invalid_user.valid?).to be false
  # end

  # it 'has a name that is not too long' do
  #   user = build :user, name: 'Nathan' * 10
  #   expect(user.valid?).to be false
  # end

  # it 'has an email that is not too long' do
  #   user = build :user, email: 'nathan.smith@ucla.edu' * 1500
  #   expect(user.valid?).to be false
  # end

  # it 'can only have a ucla email' do
  #   valid_user = build :user, email: 'nathansmith@g.ucla.edu'
  #   expect(valid_user.valid?).to be true

  #   invalid_user = build :user, email: 'nathansmith@gmail.com'
  #   expect(invalid_user.valid?).to be false
  # end

  # describe 'unfollow' do
  #   let(:term) { create :term }
  #   let(:user) { create :user }
  #   let(:sections) do
  #     sections = create_list :section, 2, term: term
  #     create :relationship, :with_review, user: user, section: sections.first
  #     create :relationship, user: user, section: sections.second
  #     sections
  #   end

  #   it 'removes a relationship' do
  #     user.unfollow sections.second
  #     expect(user.sections).to match_array [sections.first]
  #   end

  #   it 'does not remove a relationship when it is reviewed' do
  #     expect { user.unfollow sections.first }.to raise_error(ActiveRecord::RecordNotDestroyed)
  #     expect(user.sections).to match_array sections
  #   end
  # end

  # describe 'add_notification_token' do
  #   it 'adds a single notification token to a user' do
  #     user = build :user, notification_token_count: 1
  #     user.add_notification_token
  #     expect(user.notification_token_count).to be 2
  #   end
  # end

  # describe 'use_notification_token' do
  #   it 'removes a single notification token from a user and returns true' do
  #     user = build :user, notification_token_count: 3
  #     expect(user.use_notification_token).to be true
  #     expect(user.notification_token_count).to be 2
  #   end

  #   it 'returns false if a user has no notification tokens that can be used' do
  #     user = build :user, notification_token_count: 0
  #     expect(user.use_notification_token).to be false
  #     expect(user.notification_token_count).to be 0
  #   end
  # end

  # describe 'review_count_for_term' do
  #   it 'returns 0 if a user has not written any reviews' do
  #     term = build :term
  #     user = build :user
  #     expect(user.review_count_for_term(term)).to be 0
  #   end

  #   it 'returns a number if a user has written reviews for sections during that term' do
  #     term = create :term
  #     user = create :user
  #     sections = create_list :section, 2, term: term
  #     create :relationship, :with_review, user: user, section: sections.first
  #     create :relationship, :with_review, user: user, section: sections.second

  #     expect(user.review_count_for_term(term)).to be 2
  #   end
  # end

  # describe 'reviewed_course?' do
  #   it 'returns true if the user has reviewed the course' do
  #     user = create :user
  #     course = create :course
  #     section = create :section, course: course
  #     create :relationship, :with_review, user: user, section: section

  #     expect(user.reviewed_course?(course)).to be true
  #   end

  #   it 'returns false if the user has not reviewed the course' do
  #     user = create :user
  #     course = create :course
  #     section = create :section, course: course
  #     create :relationship, user: user, section: section

  #     expect(user.reviewed_course?(course)).to be false
  #   end
  # end

  # describe 'formatted_phone' do
  #   it 'returns a users phone number in a human-readable format' do
  #     user = create :user, phone: '4155720407'
  #     expect(user.formatted_phone).to eq '+1 (415) 572-0407'
  #   end
  # end

  # describe 'set_referral_code' do
  #   it 'generates a unique referral code' do
  #     user = build :user
  #     user.set_referral_code
  #     expect(user.referral_code).not_to be_nil
  #   end

  #   it 'raises an error if it cannot generate a referral code for some reason' do
  #     referral_code = 'test-code'
  #     allow(SecureRandom).to receive(:hex) { referral_code }
  #     create :user, referral_code: referral_code
  #     user = build :user
  #     expect { user.set_referral_code }.to raise_error(ActiveRecord::ActiveRecordError)
  #   end
  # end
end
