# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Mark all existing reviews as approved"
  task mark_reviews_as_approved: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger
    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info

    Review.transaction do
      reviews = Review.all
      reviews.each do |review|
        review.approved!
        review.save!
      end
    end
  end
end
