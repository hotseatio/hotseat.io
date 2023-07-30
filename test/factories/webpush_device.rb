# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :webpush_device do
    browser { "safari" }
    operating_system { "Mac OS" }
    sequence(:notification_endpoint) { |n| "https://web.push.apple.com/randomly-generated-fake-endpoint-#{n}" }
    p256dh_key { "BN4GvZtEZiZuqFxSKVZfSfluwKBD7UxHNBmWkfiZfCtgDE8Bwh-_MtLXbBxTBAWH9r7IPKL0lhdcaqtL1dfxU5E=" }
    auth_key { "Q2BoAjC09xH3ywDLNJr-dA==" }
  end
end
