# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Backfill the first_approved_at date for already approved reviews"
  task backfill_subscribers_to_announcements_mailing_list: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger

    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info

    ActiveRecord::Base.transaction do
      User.all.find_each do |user|
        user.subscribe("announcements") unless user.subscribed?("announcements")
        user.save
      end
    end
  end
end
