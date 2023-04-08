# typed: strict
# frozen_string_literal: true

# A WebpushDevice is a device/browser (phone, computer, etc.) set up to receive web push notifications.
class WebpushDevice < ApplicationRecord
  belongs_to :user
end
