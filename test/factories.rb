# typed: false
# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :user do
    name { "Nathan Smith" }
    sequence(:email) { |n| "natedub#{n}@g.ucla.edu" }
    provider { "google_oauth2" }
    sequence(:uid) { |n| n }
    notification_token_count { 1 }
  end

  factory :term do
    sequence(:term) do |n|
      quarters = %w[W S F 1]
      years = %w[99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]
      years.product(quarters).map(&:join)[n]
    end
  end

  factory :enrollment_appointment

  factory :subject_area do
    name { "Computer Science" }
    sequence(:code) { |n| "COM SCI#{n}" }
  end

  factory :course do
    subject_area { association(:subject_area) }
    sequence(:title, 1) { |n| "Introduction to Computer Science #{'I' * n}" }
    sequence(:number, 1) { |n| (30 + n).to_s }

    trait :reindex do
      after(:create) do |course, _evaluator|
        course.reindex(refresh: true)
      end
    end
  end

  factory :section do
    course { association(:course) }
    term { association(:term) }
    instructor { association(:instructor) }
    registrar_id { |n| "1870962#{n}" }
    days { ["MW"] }
    times { ["10am-11:50am"] }
    locations { ["Online"] }
    enrollment_status { "Open" }
    enrollment_count { 169 }
    enrollment_capacity { 200 }
    waitlist_status { "None" }
    waitlist_count { 0 }
    waitlist_capacity { 20 }
    format { "LEC" }
    index { 1 }
  end

  factory :textbook do
    isbn { "9781319050733" }
    title { "Calculus" }
  end

  factory :instructor do
    registrar_listing { ["#{Faker::Name.unique.last_name}, P."] }

    trait :reindex do
      after(:create) do |instructor, _evaluator|
        instructor.reindex(refresh: true)
      end
    end
  end

  factory :relationship do
    user
    section

    trait :with_review do
      review
    end
  end

  factory :review do
    relationship
    user
    section

    organization { 4 }
    clarity { 4 }
    overall { 4 }
    weekly_time { "10-15" }
    comments { Faker::Lorem.paragraph }

    has_group_project { false }
    midterm_count { 2 }
    requires_attendance { false }
    final { "finals" }
    reccomend_textbook { false }
  end
end
