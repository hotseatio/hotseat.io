# typed: strict
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend T::Sig
  protect_from_forgery with: :exception
  before_action :set_referral_cookie

  # Required by Devise
  # https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview#using-omniauth-without-other-authentications
  sig { params(_scope: T.untyped).returns(String) }
  def new_session_path(_scope)
    new_user_session_path
  end

  sig { params(_user: T.untyped).returns(T.untyped) }
  def after_sign_in_path_for(_user)
    my_courses_path
  end

  sig { void }
  def set_referral_cookie
    return unless params[:ref]

    user = User.find_by(referral_code: params[:ref])
    return if user.nil? || user_signed_in?

    flash.now[:success] = {
      title: 'Welcome to Hotseat!',
      message: "#{user.name} has referred you to Hotseat. As a bonus for signing up and writing a review, you'll receive 2 notification tokens, for text alerts on any class!",
      link: new_user_session_path,
      link_title: 'Sign up now ➡️',
    }

    cookies[:referral_code] = {
      value: params[:ref],
      expires: 30.days.from_now,
    }
  end

  # Used by lograge
  # https://www.datadoghq.com/blog/managing-rails-application-logs/#setting-appropriate-log-levels
  sig { params(payload: T.untyped).returns(T.untyped) }
  def append_info_to_payload(payload)
    super
    payload[:level] = case payload[:status]
                      when 200
                        'INFO'
                      when 302
                        'WARN'
                      else
                        'ERROR'
                      end
  end
end
