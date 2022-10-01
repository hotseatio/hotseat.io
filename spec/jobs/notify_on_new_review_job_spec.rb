# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotifyOnNewReviewJob, type: :job do
  it 'posts the review to slack' do
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
    allow(ENV).to receive(:fetch).with('SLACK_WEBHOOK_URL').and_return('https://slack.com/secret-webhook')
    stub_request(:post, 'https://slack.com/secret-webhook')
      .to_return(status: 200, body: '', headers: {})

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
    described_class.perform_now(review)
  end
end
