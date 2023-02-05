# typed: strict
# frozen_string_literal: true

require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  describe "phone verification" do
    describe "POST /users/verify-phone" do
      it "texts an otp" do
        user = create(:user)
        phone = Faker::PhoneNumber.cell_phone
        formatted_phone = User.format_phone(phone)

        T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
        T.unsafe(User).any_instance.stubs(:generate_otp_code).returns("123456")

        resp = <<~RESPONSE
          <PublishResponse xmlns="https://sns.amazonaws.com/doc/2010-03-31/">
              <PublishResult>
                  <MessageId>94f20ce6-13c5-43a0-9a9e-ca52d816e90b</MessageId>
              </PublishResult>
              <ResponseMetadata>
                  <RequestId>f187a3c1-376f-11df-8963-01868b7c937a</RequestId>
              </ResponseMetadata>
          </PublishResponse>
        RESPONSE
        stub_request(:post, "https://sns.us-east-1.amazonaws.com/")
          .with(
            body: {
              "Action" => "Publish",
              "Message" => "Your Hotseat code: 123456",
              "PhoneNumber" => formatted_phone,
              "Version" => "2010-03-31",
            },
          )
          .to_return(status: 200, body: resp)

        sign_in user
        post "/users/verify-phone", params: { phone: }

        assert_response :ok
        assert_equal "Verification code sent", response.parsed_body["msg"]
        assert_equal formatted_phone, response.parsed_body["formattedPhone"]
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
