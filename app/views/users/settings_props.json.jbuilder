# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
json.key_format!(camelize: :lower)

user = T.let(T.unsafe(current_user), User)
extend UserHelper # rubocop:disable Style/MixinUsage

json.update_url(user_path(user))
json.name(user.name)
json.email(user.email)
json.phone_number(user.formatted_phone)
json.beta_tester(user.beta_tester)
json.referral_link(referral_url(user))
json.devices(user.webpush_devices.order(:id), partial: "webpush_devices/device", as: :device)
