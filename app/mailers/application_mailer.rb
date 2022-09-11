# typed: strict
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@hotseat.io'
  layout 'mailer'
end
