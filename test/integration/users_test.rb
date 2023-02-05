# typed: strict
# frozen_string_literal: true

require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  describe "phone verification" do
    describe "POST /users/verify-phone" do
      it "texts an otp" do
        # TODO: implement
      end

      it "does not text in development mode" do
        # TODO: implement
      end
    end

    describe "POST /users/confirm-verify-phone" do
      it "verifies a phone number with the correct otp code" do
        # TODO: implement
      end

      it "returns an error if the wrong otp code is given" do
        # TODO: implement
      end

      it "always successfully verifies in development mode" do
        # TODO: implement
      end
    end

    describe "PUT /users/remove-phone" do
      it "removes the phone number from a user and removes notifications from all their courses" do
        # TODO: implement
      end
    end
  end
end
