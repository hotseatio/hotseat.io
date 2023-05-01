# typed: strict
# frozen_string_literal: true

# A WebpushDevice is a device/browser (phone, computer, etc.) set up to receive web push notifications.
class WebpushDevice < ApplicationRecord
  extend T::Sig

  belongs_to :user

  # sig { params(message).void }
  sig { void }
  def send_push
    WebPush.payload_send(
      endpoint: notification_endpoint,
      message: "Test notification",
      p256dh: p256dh_key,
      auth: auth_key,
      vapid: {
        subject: "https://hotseat.io",
        public_key: ENV.fetch("VAPID_PUBLIC_KEY", nil),
        private_key: ENV.fetch("VAPID_PRIVATE_KEY", nil),
      },
    )
  end
end
