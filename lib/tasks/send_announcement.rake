# typed: strict
# frozen_string_literal: true

# Add Sorbet support
# https://sorbet.org/docs/faq#does-sorbet-work-with-rake-and-rakefiles
extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :send_announcement do
  desc "Update Sorbet and Sorbet Rails RBIs."
  task push_notifications_2023_05_16: :environment do
    User.subscribed("announcements").each do |user|
      AnnouncementsMailer.with(user:).push_notifications_2023_05_16.deliver_now
    end
  end
end
