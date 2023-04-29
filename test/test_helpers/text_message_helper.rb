# typed: strict
# frozen_string_literal: true

module TextMessageHelper
  extend T::Sig

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

  sig { params(message: String, phone: String).void }
  def stub_text_message_send(message:, phone:)
    WebMock.stub_request(:post, "https://sns.us-east-1.amazonaws.com/")
           .with(
             body: {
               "Action" => "Publish",
               "Version" => "2010-03-31",
               "Message" => message.strip,
               "PhoneNumber" => phone,
             },
           )
           .to_return(status: 200, body: FAKE_RESPONSE)
  end
end
