# typed: strict
# frozen_string_literal: true

class CheckoutsController < ApplicationController
  extend T::Sig
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  sig { void }
  def initialize
    super
    @checkout_session = T.let(nil, T.untyped)
    # Use Stripe livemode price in production, testmode for all other data
    @price = T.let(T.unsafe(Rails.env).production? ? "price_1KXuuBBclLivpoJujRNSkGJ4" : "price_1KXuv2BclLivpoJuWavz9GPj", String)
  end

  sig { void }
  def checkout
    user = T.must(current_user)
    user.set_payment_processor(:stripe)

    @checkout_session = T.unsafe(user.payment_processor).checkout(
      mode: "payment",
      line_items: @price,
      success_url: my_courses_url(payment_success: true),
      cancel_url: my_courses_url,
      automatic_tax: { enabled: true },
      customer_update: { address: "auto" },
    )
    logger.info("Created checkout session url=#{@checkout_session.url}")

    redirect_to(@checkout_session.url, allow_other_host: true, status: :see_other)
  end
end
