# typed: strict
# frozen_string_literal: true

class AnnouncementsMailer < ApplicationMailer
  extend T::Sig

  default to: "no-reply@hotseat.io", from: "no-reply@hotseat.io", bcc: -> { User.subscribed("announcements").pluck(:email) }

  sig { void }
  def push_notifications_2023_05_16
    mail(subject: "Hotseat: Introducing native notifications on all your devices")
  end
end
