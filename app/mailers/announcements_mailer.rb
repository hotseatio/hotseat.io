# typed: strict
# frozen_string_literal: true

class AnnouncementsMailer < ApplicationMailer
  extend T::Sig

  sig { void }
  def initialize
    super
    @mailkick_list = T.let("announcements", String)
  end

  # default to: "no-reply@hotseat.io", from: "no-reply@hotseat.io", bcc: -> { User.subscribed("announcements").pluck(:email) }

  sig { void }
  def push_notifications_2023_05_16
    @user = T.let(params[:user], T.nilable(User))
    mail(to: T.must(@user).email, subject: "Hotseat: Introducing native notifications on all your devices")
  end
end
