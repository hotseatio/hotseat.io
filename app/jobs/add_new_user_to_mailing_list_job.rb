# typed: strict
# frozen_string_literal: true

class AddNewUserToMailingListJob < ApplicationJob
  extend T::Sig
  queue_as :default
  include UserHelper

  sig { params(user: User).void }
  def perform(user)
    api_key = ENV.fetch('MAILCHIMP_API_KEY')
    server = ENV.fetch('MAILCHIMP_SERVER')
    list_id = ENV.fetch('MAILCHIMP_LIST_ID')

    client = MailchimpMarketing::Client.new({ api_key:, server: })
    name_parts = user.name.split
    client.lists.add_list_member(list_id, {
                                   email_address: user.email,
                                   status: 'subscribed',
                                   merge_fields: {
                                     FNAME: name_parts.first,
                                     LNAME: name_parts.last,
                                   },
                                 })
    logger.info("Added user #{user.id} to mailing list.")
  rescue MailchimpMarketing::ApiError => e
    logger.error(e)
  end
end
