# typed: strict
# frozen_string_literal: true

class AnnouncementsMailer < ApplicationMailer
  extend T::Sig

  sig { void }
  def initialize
    super
    @mailkick_list = T.let("announcements", String)
  end

  default from: email_address_with_name("announcements@hotseat.io", "Team Hotseat")

  sig { void }
  def push_notifications_2023_05_16
    @user = T.let(params[:user], T.nilable(User))
    mail(
      to: email_address_with_name(T.must(@user).email, T.must(@user).name),
      subject: "Hotseat: Introducing native notifications on all your devices",
    )
  end
end
