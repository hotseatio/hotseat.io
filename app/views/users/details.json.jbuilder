# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
@user = T.let(@user, User)

json.notification_tokens @user.notification_token_count
json.phone @user.formatted_phone
json.beta_tester @user.beta_tester
