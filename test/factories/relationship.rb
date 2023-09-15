# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    user
    section
    stored_status { "planned" }

    trait :with_review do
      review
    end

    traits_for_enum :stored_status, planned: "planned",
                                    subscribed: "subscribed",
                                    enrolled: "enrolled"
  end
end
