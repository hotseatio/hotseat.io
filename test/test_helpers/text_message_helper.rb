# typed: strict
# frozen_string_literal: true

module TextMessageHelper
  extend T::Sig
  include WebMock::API

  AWS_ENDPOINT = "https://sns.us-east-1.amazonaws.com/"
  FAKE_RESPONSE = <<~RESPONSE
    <PublishResponse xmlns="https://sns.amazonaws.com/doc/2010-03-31/">
        <PublishResult>
            <MessageId>94f20ce6-13c5-43a0-9a9e-ca52d816e90b</MessageId>
        </PublishResult>
        <ResponseMetadata>
            <RequestId>f187a3c1-376f-11df-8963-01868b7c937a</RequestId>
        </ResponseMetadata>
    </PublishResponse>
  RESPONSE

  sig { params(message: T.nilable(String), phone: T.nilable(String)).void }
  def stub_text_message_send(message: nil, phone: nil)
    if message && phone
      stub_request(:post, AWS_ENDPOINT)
        .with(body: construct_body(message, phone))
        .to_return(status: 200, body: FAKE_RESPONSE)
    else
      stub_request(:post, AWS_ENDPOINT)
        .to_return(status: 200, body: FAKE_RESPONSE)
    end
  end

  sig { params(message: String, phone: String).void }
  def assert_text_message_send(message:, phone:)
    assert_requested(:post, AWS_ENDPOINT, body: construct_body(message, phone), times: 1)
  end

  private

  sig { params(message: String, phone: String).returns(T::Hash[String, String]) }
  def construct_body(message, phone)
    {
      "Action" => "Publish",
      "Version" => "2010-03-31",
      "Message" => message.strip,
      "PhoneNumber" => phone,
    }
  end
end
