# typed: strict
# frozen_string_literal: true

class NotifyOnNewReviewJob < ApplicationJob
  extend T::Sig
  queue_as :default

  sig { params(review: Review).void }
  def perform(review)
    logger.info("Starting NotifyOnNewReviewJob")
    webhook_url = ENV.fetch("SLACK_WEBHOOK_URL")

    text = <<~MESSAGE
      New review ##{review.id} created at #{review.created_at} by user ##{T.must(review.user).id}

      Numbers
      =======
      Overall: #{review.overall}
      Clarity: #{review.clarity}
      Organization: #{review.organization}
      Workload: #{review.weekly_time}

      Grade: #{review.grade}
      Group project: #{review.has_group_project}
      Attendance: #{review.requires_attendance}
      Midterms: #{review.midterm_count}
      Final: #{review.final}
      Extra credit: #{review.offers_extra_credit}

      Comments:
      =========
      Comments: #{review.comments}

    MESSAGE

    text.prepend("DEVELOPMENT\n\n") if T.unsafe(Rails.env).development?

    logger.info("Posting review to Slack: #{review.id}")
    response = HTTParty.post(webhook_url, {
                               body: { text: }.to_json,
                               headers: { "Content-type" => "application/json" },
                             })
    logger.info("Slack response returned: #{response.code}")
    logger.info("Finished NotifyOnNewReviewJob")
  end
end
