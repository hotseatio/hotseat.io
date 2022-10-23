# typed: strict
# frozen_string_literal: true

require 'test_helper'

class AddNewUserToMailingListJobTest < ActiveJob::TestCase
  it 'adds the new user to Mailchimp if in production' do
    server = 'mailchimpserver'
    list_id = 'testlistid'
    api_key = 'testmailchimpapikey'

    user = create(:user, name: 'Nathan Smith', email: 'nathan@g.ucla.edu')
    stub_request(:post, "https://#{server}.api.mailchimp.com/3.0/lists/#{list_id}/members")
      .with(
        body: {
          email_address: 'nathan@g.ucla.edu',
          status: 'subscribed',
          merge_fields: { FNAME: 'Nathan', LNAME: 'Smith' },
        }.to_json,
      )
      .to_return(status: 200, body: '{}', headers: {})
    T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new('production'))

    ClimateControl.modify MAILCHIMP_SERVER: server, MAILCHIMP_LIST_ID: list_id, MAILCHIMP_API_KEY: api_key do
      AddNewUserToMailingListJob.perform_now(user)
    end
  end
end
