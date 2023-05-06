# typed: strict
# frozen_string_literal: true

# A WebpushDevice is a device/browser (phone, computer, etc.) set up to receive web push notifications.
class WebpushDevice < ApplicationRecord
  extend T::Sig

  belongs_to :user

  class Action < T::Struct
    const :action, String
    const :title, String
    # const :icon, String
  end

  class PushNotification < T::Struct
    const :title, String
    const :body, String
    const :tag, String
    const :status, String
    const :actions, T::Array[Action]
  end

  sig { params(notification: PushNotification).void }
  def send_push(notification)
    WebPush.payload_send(
      endpoint: notification_endpoint,
      message: notification.serialize.to_json,
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
