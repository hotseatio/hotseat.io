# typed: strict
# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/announcements_mailer
class AnnouncementsMailerPreview < ActionMailer::Preview
  extend T::Sig

  sig { returns(ActionMailer::MessageDelivery) }
  def push_notifications_2023_05_16
    AnnouncementsMailer.with(user: User.find_by(name: "Nathan Smith")).push_notifications_2023_05_16
  end
end
