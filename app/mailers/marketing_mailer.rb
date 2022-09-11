# typed: strict
# frozen_string_literal: true

class MarketingMailer < ApplicationMailer
  extend T::Sig

  sig { void }
  def initialize
    super
    @user = T.let(nil, T.nilable(User))
  end

  sig { void }
  def september2022
    @user = params[:user]
    mail(to: @user.email, subject: 'Hotseat: Looking for developers, designers, product managers, and marketers!')
  end
end
