# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddNewUserToMailingListJob, type: :job do
  it 'adds the new user to Mailchimp if in production' do
    server = 'mailchimpserver'
    list_id = 'testlistid'
    api_key = 'testmailchimpapikey'

    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
    stub_const('ENV', ENV.to_hash.merge(
                        'MAILCHIMP_SERVER' => server,
                        'MAILCHIMP_LIST_ID' => list_id,
                        'MAILCHIMP_API_KEY' => api_key,
                      ))

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

    described_class.perform_now(user)
  end
end
