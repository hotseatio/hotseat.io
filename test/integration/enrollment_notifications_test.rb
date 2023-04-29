# typed: strict
# frozen_string_literal: true

require "test_helper"

class CoursesTest < ActionDispatch::IntegrationTest
  describe "POST /enrollment_notifications" do
    it "returns a 400 if an incorrect auth token is given" do
      # TODO: implement
    end

    it "returns an error if the required params aren't given" do
      # TODO: implement
    end

    it "sends out notifications to all users subscribed to the section" do
      # TODO: implement
    end

    it "does not send any notifications if no users are subscribed" do
      # TODO: implement
    end

    it "does not send any notifications if enrollment has ended -- i.e., is past EOD Friday week 3" do
      # TODO: implement
    end
  end
end
