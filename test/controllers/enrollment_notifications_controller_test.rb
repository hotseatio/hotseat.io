# typed: strict
# frozen_string_literal: true

require "test_helper"

class CoursesTest < ActionDispatch::IntegrationTest
  describe "POST /enrollment_notifications" do
    before do
      @token = T.let("test-token", String)
      ENV["ENROLLMENT_NOTIFICATION_API_TOKEN"] = @token

      @term = T.let(create_current_term, Term)
    end

    it "returns a 400 if an incorrect auth token is given" do
      token = "blah-bad-token"
      post "/enrollment_notifications", headers: {
        Authorization: "Bearer #{token}",
      }
      assert_response :unauthorized
    end

    it "sends out notifications to all users subscribed to the section" do
      phone1 = User.normalize_phone(Faker::PhoneNumber.cell_phone)
      phone2 = User.normalize_phone(Faker::PhoneNumber.cell_phone)

      user1 = create(:user, name: "Nathan Smith", email: "nathan@g.ucla.edu", phone: phone1)
      user2 = create(:user, name: "Tim Gu", email: "tim@g.ucla.edu", phone: phone2)
      user3 = create(:user, name: "Paul Eggert", email: "eggert@g.ucla.edu")
      create(:user, name: "Bob Loblaw", email: "loblaw@g.ucla.edu")

      section = create(:section, term: @term, enrollment_status: "Open")
      create(:relationship, section:, user: user1, notify: true)
      create(:relationship, section:, user: user2, notify: true)
      create(:relationship, section:, user: user3, notify: false)

      message = <<~MESSAGE
        Hotseat Alert: #{section.course_title} enrollment status changed from Closed to Open.

        Enroll now: http://localhost:3000/enroll/#{section.id}

        Already enrolled? Unsubscribe: http://localhost:3000/unsubscribe/#{section.id}
      MESSAGE

      stub_text_message_send(message:, phone: T.must(phone1))
      stub_text_message_send(message:, phone: T.must(phone2))

      perform_enqueued_jobs do
        post "/enrollment_notifications",
             headers: {
               Authorization: "Bearer #{@token}",
             },
             params: {
               section_id: section.id,
               previous_enrollment_numbers: {
                 enrollment_status: "Closed",
                 enrollment_count: 100,
                 enrollment_capacity: 100,
                 waitlist_status: "None",
                 waitlist_count: 0,
                 waitlist_capacity: 0,
               },
             }
      end
      assert_response :success
      assert_equal({ "notifications_sent" => 2 }, response.parsed_body)
      assert_performed_jobs 4
    end

    it "does not send any notifications if no users are subscribed" do
      section = create(:section, term: @term, enrollment_status: "Open")

      perform_enqueued_jobs do
        post "/enrollment_notifications",
             headers: {
               Authorization: "Bearer #{@token}",
             },
             params: {
               section_id: section.id,
               previous_enrollment_numbers: {
                 enrollment_status: "Closed",
                 enrollment_count: 100,
                 enrollment_capacity: 100,
                 waitlist_status: "None",
                 waitlist_count: 0,
                 waitlist_capacity: 0,
               },
             }
      end
      assert_response :success
      assert_equal({ "notifications_sent" => 0 }, response.parsed_body)
      assert_performed_jobs 0
    end

    it "does not send any notifications for a section if the term is not current or upcoming" do
      not_current_term = create(:term)
      section = create(:section, term: not_current_term, enrollment_status: "Open")

      perform_enqueued_jobs do
        post "/enrollment_notifications",
             headers: {
               Authorization: "Bearer #{@token}",
             },
             params: {
               section_id: section.id,
               previous_enrollment_numbers: {
                 enrollment_status: "Closed",
                 enrollment_count: 100,
                 enrollment_capacity: 100,
                 waitlist_status: "None",
                 waitlist_count: 0,
                 waitlist_capacity: 0,
               },
             }
      end
      assert_response :success
      assert_equal({ "notifications_sent" => 0, "not_enrollable" => true }, response.parsed_body)
      assert_performed_jobs 0
    end
  end
end
