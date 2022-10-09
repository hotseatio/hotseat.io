# typed: strict
# frozen_string_literal: true

module UserHelper
  extend T::Sig

  sig { params(user: User).returns(String) }
  def referral_url(user)
    root_url(params: { ref: user.referral_code })
  end
end
