# typed: strict
# frozen_string_literal: true

require "test_helper"

class NotifyUserAboutApprovedReviewJobTest < ActiveJob::TestCase
  it "texts the user that their review was approved" do
    phone = "+12025550124"
    user = create(:user, phone:)

    subject_area = create(:subject_area, name: "Blah", code: "BLAH")
    course = create(:course, title: "Intro to Blah Studies", number: "10", subject_area:)
    section = create(:section, course:)
    review = create(:review, user:, section:)

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
          "Message" => "Your Hotseat review for BLAH 10: Intro to Blah Studies was approved. You now have 1 notification tokens.\n",
          "PhoneNumber" => phone,
          "Version" => "2010-03-31",
        },
      )
      .to_return(status: 200, body: resp)

    NotifyUserAboutApprovedReviewJob.perform_now(review)
  end
end
