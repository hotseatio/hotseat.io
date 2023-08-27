# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Copy relationship ids to reviews"
  task copy_relationship_ids_to_reviews: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger
    Rails.logger.level = :info
    Rails.logger.info("Searching all users for missing referral codes...")

    Relationship.find_each do |relationship|
      review_id = T.unsafe(relationship).review_id
      if review_id
        Rails.logger.info("Review found, setting relationship id #{relationship.id} on review #{review_id}")
        review = Review.find(review_id)
        review.relationship_id = relationship.id
        review.save!
      else
        Rails.logger.info("Skipping relationship without review: #{relationship.id}")
      end
    end

    Rails.logger.info("Destroying orphaned reviews")
    Review.where(relationship_id: nil).destroy_all
  end
end
