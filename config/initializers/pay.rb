# typed: strict
# frozen_string_literal: true

Pay.setup do |config|
  config.send_emails = false
end

fulfill_checkout = lambda { |event|
  checkout_session = event.data.object
  customer = Pay::Customer.find_by(processor_id: checkout_session.customer)
  return if customer.nil?
  return if checkout_session.payment_status != 'paid'

  user = T.cast(customer.owner, User)
  user.add_notification_token(count: 4)
  Rails.logger.info "Added 4 tokens to user: #{user.id}"
}

Pay::Webhooks.delegator.subscribe 'stripe.checkout.session.async_payment_succeeded', fulfill_checkout
Pay::Webhooks.delegator.subscribe 'stripe.checkout.session.completed', fulfill_checkout
