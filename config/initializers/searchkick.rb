# typed: strict
# frozen_string_literal: true

if T.unsafe(Rails.env).production?
  Searchkick.aws_credentials = {
    access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil),
    region: ENV.fetch('AWS_REGION', nil),
  }
end
