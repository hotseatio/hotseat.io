# typed: true
# frozen_string_literal: true

class MarketingMailerPreview < ActionMailer::Preview
  extend T::Sig

  def october2022
    MarketingMailer.with(user: User.first).october2022
  end
end
