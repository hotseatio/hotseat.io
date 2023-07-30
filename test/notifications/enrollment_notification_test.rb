# typed: strict
# frozen_string_literal: true

require "test_helper"

class EnrollmentNotificationTest < ActiveSupport::TestCase
  describe "text messages" do
    it "sends a text message to a user" do
      term = T.let(create_current_term, Term)
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      user = create(:user, phone:)
      section = create(:section, term:, enrollment_status: "Open")
      create(:relationship, section:, user:, notify: true)
      message = <<~MESSAGE
        Hotseat Alert: #{section.course_title} enrollment status changed from Closed to Open.

        Enroll now: http://localhost:3000/enroll/#{section.id}

        Already enrolled? Unsubscribe: http://localhost:3000/unsubscribe/#{section.id}
      MESSAGE

      stub_text_message_send(message:, phone:)

      EnrollmentNotification.with(
        timestamp: Time.now.to_i,
        section:,
        previous_enrollment_numbers: {
          enrollment_status: "Closed",
          enrollment_count: 100,
          enrollment_capacity: 100,
          waitlist_status: "None",
          waitlist_count: 0,
          waitlist_capacity: 0,
        },
      ).deliver(user)
      assert_text_message_send(message:, phone:)
    end
  end

  describe "web push" do
    it "sends a web push to a beta tester" do
      term = T.let(create_current_term, Term)
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      user = create(:user, beta_tester: true, phone:)
      device = create(:webpush_device, user:)
      section = create(:section, term:, enrollment_status: "Open")

      create(:relationship, section:, user:, notify: true)

      stub_text_message_send
      stub_webpush_send(device)

      EnrollmentNotification.with(
        timestamp: Time.now.to_i,
        section:,
        previous_enrollment_numbers: {
          enrollment_status: "Closed",
          enrollment_count: 100,
          enrollment_capacity: 100,
          waitlist_status: "None",
          waitlist_count: 0,
          waitlist_capacity: 0,
        },
      ).deliver(user)

      assert_webpush_send(device)
    end
  end
end
