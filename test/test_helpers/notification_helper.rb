# typed: strict
# frozen_string_literal: true

module NotificationHelper
  extend T::Sig

  sig { params(notification_class: T.class_of(Noticed::Base), user: User, kwargs: T.anything).void }
  def expect_notification_to_be_sent(notification_class, user, **)
    notification = notification_class.with(**)
    Mock.expects(notification_class, :with).with(**).returns(notification)
    Mock.expects(notification, :deliver_later).with(user)
  end

  sig { params(notification_class: T.class_of(Noticed::Base)).void }
  def expect_notification_not_to_be_sent(notification_class)
    T.unsafe(Mock.expects(notification_class, :with)).never
    T.unsafe(Mock.expects(T.unsafe(notification_class).any_instance, :deliver_later)).never
  end
end
