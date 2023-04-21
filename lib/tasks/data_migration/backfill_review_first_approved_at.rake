# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Backfill the first_approved_at date for already approved reviews"
  task backfill_review_first_approved_at: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger

    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info

    ActiveRecord::Base.transaction do
      reviews = Review.where(status: "approved", first_approved_at: nil)
      reviews.update_all(first_approved_at: Time.zone.now)
    end
  end
end
