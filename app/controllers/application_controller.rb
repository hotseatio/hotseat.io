# typed: strict
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend T::Sig
  protect_from_forgery with: :exception
  before_action :set_referral_cookie

  include Devise::Controllers::Helpers

  # Required by Devise
  # https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview#using-omniauth-without-other-authentications
  sig { params(_scope: T.untyped).returns(String) }
  def new_session_path(_scope)
    new_user_session_path
  end

  sig { params(resource_or_scope: T.untyped).returns(T.untyped) }
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  sig { void }
  def set_referral_cookie
    return unless params[:ref]

    user = User.find_by(referral_code: params[:ref])
    return if user.nil? || user_signed_in?

    flash.now[:success] = {
      title: "Welcome to Hotseat!",
      message: "#{user.name} has referred you to Hotseat. As a bonus for signing up and writing a review, you'll receive 2 notification tokens, for text alerts on any class!",
      link: new_user_session_path,
      link_title: "Sign up now ➡️",
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
                        "INFO"
                      when 302
                        "WARN"
                      else
                        "ERROR"
                      end
  end

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  sig { returns(T::Boolean) }
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  sig { returns(T.untyped) }
  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
