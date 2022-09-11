# typed: strict
# frozen_string_literal: true

class MarketingMailer < ApplicationMailer
  extend T::Sig

  sig { void }
  def september2022
    # @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Hotseat: Looking for developers, designers, product managers, and marketers!')
  end
end
