# typed: false
# frozen_string_literal: true

json = T.unsafe(json)
json.key_format!(camelize: :lower)

user = T.let(T.unsafe(current_user), User)
# extend UserHelper

json.update_url(user_path(user))
json.name(user.name)
json.email(user.email)
json.phone_number(user.formatted_phone)
json.beta_tester(user.beta_tester)
json.referral_link(referral_url(user))
json.devices(user.webpush_devices.order(:id), partial: "webpush_devices/device", as: :device)
json.notification_preferences do
  json.child! do
    json.id("announcements")
    json.email(user.subscribed?("announcements"))
    json.sms(nil)
    json.push(nil)
  end
  json.child! do
    json.id("enrollment_notifications")
    json.email(nil)
    json.sms(user.enrollment_sms_notifications)
    json.push(user.enrollment_web_push_notifications)
  end
end
