# typed: strict
# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  extend T::Sig
  include Devise::Controllers::Rememberable

  # skip_before_action :authenticate_user!, raise: false
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  sig { void }
  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth, referral_code: cookies[:referral_code])

    remember_me(user)

    if user.persisted?
      flash[:success] = "Successfully logged in! Welcome to Hotseat!"
      sign_in_and_redirect(user)
    else
      flash[:error] = "Error logging in. Please try again."
      redirect_to(new_user_session_path)
    end
  end

  sig { void }
  def failure
    redirect_to(root_path)
  end
end
