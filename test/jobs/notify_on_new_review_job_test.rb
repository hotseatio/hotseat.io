# typed: false
# frozen_string_literal: true

require 'rails_helper'

class NotifyOnNewReviewJobTest < ActiveJob::TestCase
  it 'posts the review to slack' do
    T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new('production'))
    user = create(:user)
    review = create(:review,
                    user:,
                    overall: 4,
                    clarity: 4,
                    organization: 4,
                    weekly_time: '10-15',
                    grade: 'C+',
                    has_group_project: true,
                    requires_attendance: false,
                    midterm_count: 2,
                    final: 'finals',
                    offers_extra_credit: true)
    stub_request(:post, 'https://slack.com/secret-webhook')
      .to_return(status: 200, body: '', headers: {})

    ClimateControl.modify SLACK_WEBHOOK_URL: 'https://slack.com/secret-webhook' do
      described_class.perform_now(review)
    end
  end
end
