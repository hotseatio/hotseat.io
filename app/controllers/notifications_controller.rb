# typed: strict
# frozen_string_literal: true

class NotificationsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!

  class CreateParams < T::Struct
    const :browser, String
    const :version, String
    const :os, String
    const :endpoint, String
    const :auth, String
    const :p256dh, String
  end

  sig { void }
  def create
    typed_params = TypedParams[CreateParams].new.extract!(params)

    WebpushDevice.create(
      user: current_user,
      browser: typed_params.browser,
      version: typed_params.version,
      operating_system: typed_params.os,
      notification_endpoint: typed_params.endpoint,
      auth_key: typed_params.auth,
      p256dh_key: typed_params.p256dh,
    )
  end
end
