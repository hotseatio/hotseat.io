# typed: strict
# frozen_string_literal: true

# To deliver this notification:
#
# EnrollmentNotification.with(post: @post).deliver_later(current_user)
# EnrollmentNotification.with(post: @post).deliver(current_user)

class EnrollmentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
