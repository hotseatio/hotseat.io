# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :webpush_device do
    browser { "safari" }
    operating_system { "Mac OS" }
    sequence(:notification_endpoint) { |n| "https://web.push.apple.com/randomly-generated-fake-endpoint-#{n}" }
    auth_key { "fake-auth-key" }
    p256dh_key { "fake-auth-key" }
  end
end
