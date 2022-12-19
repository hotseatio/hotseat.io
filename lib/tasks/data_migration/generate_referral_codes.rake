# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc 'Generate a unique referral code for all existing users.'
  task generate_user_referral_codes: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger
    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info
    Rails.logger.info('Searching all users for missing referral codes...')

    User.find_each do |user|
      if user.referral_code.blank?
        user.set_referral_code
        user.save!
        Rails.logger.info("Found user #{user.id} without referral code, generated code: #{user.referral_code}")
      else
        Rails.logger.info("User #{user.id} already has referral code, skipping")
      end
    end
  end
end
