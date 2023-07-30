# typed: strict
# frozen_string_literal: true

module WebpushHelper
  extend T::Sig
  include WebMock::API

  sig { params(device: WebpushDevice).void }
  def stub_webpush_send(device)
    stub_request(:post, device.notification_endpoint)
      .to_return(status: 200)
  end

  sig { params(device: WebpushDevice).void }
  def assert_webpush_send(device)
    assert_requested(:post, device.notification_endpoint, times: 1)
  end
end
