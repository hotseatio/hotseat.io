# typed: strict
# frozen_string_literal: true

require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /checkout" do
    before do
      WebMock.stub_request(:post, "https://api.stripe.com/v1/customers")
             .with(
               body: { "email" => "nathan@g.ucla.edu", "name" => "Nathan Smith" },
             ).to_return(status: 200, body: {
               id: "cus_9s6XBnVi5gbXub",
               object: "customer",
               created: 1_483_565_364,
               currency: "usd",
               default_source: "card_1N0Rse2eZvKYlo2CMGmpFXta",
             }.to_json)
      WebMock.stub_request(:post, "https://api.stripe.com/v1/checkout/sessions")
             .with(
               body: {
                 "cancel_url" => "http://www.example.com/my-courses?session_id={CHECKOUT_SESSION_ID}",
                 "customer" => "cus_9s6XBnVi5gbXub",
                 "line_items" => [
                   { "price" => "price_1KXuv2BclLivpoJuWavz9GPj", "quantity" => "1" },
                 ],
                 "mode" => "payment",
                 "payment_method_types" => ["card"],
                 "success_url" => "http://www.example.com/my-courses?payment_success=true&session_id={CHECKOUT_SESSION_ID}",
               },
             ).to_return(status: 200, body: {
               id: "cs_test_a1a77g2ifHiCUrfOSVzHdO1xW7JO1yMdW3whYCkRpW6q90pOsiGmzN7ipb",
               object: "checkout.session",
               cancel_url: "https://example.com/cancel",
               created: 1_685_027_209,
               customer_details: {
                 email: "example@example.com",
               },
               expires_at: 1_685_027_209,
               livemode: false,
               mode: "payment",
               payment_intent: "pi_1GszdG2eZvKYlo2CfEcSjBgX",
               payment_method_types: ["card"],
               payment_status: "unpaid",
               status: "open",
               success_url: "https://example.com/success",
               url: "https://checkout.stripe.com/c/pay/TEST_CHECKOUT_SESSION_123",
             }.to_json)
    end

    it "redirects to a Stripe checkout page" do
      user = create(:user, email: "nathan@g.ucla.edu", name: "Nathan Smith")
      sign_in user

      get "/checkout"
      assert_response :see_other
      assert_redirected_to "https://checkout.stripe.com/c/pay/TEST_CHECKOUT_SESSION_123"
    end
  end
end
