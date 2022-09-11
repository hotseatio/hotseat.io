# typed: strict
# frozen_string_literal: true

require 'aws-sdk-lambda'
require 'base64'

module LambdaScraper
  extend T::Sig

  @client = T.let(Aws::Lambda::Client.new(region: 'us-east-1'), Aws::Lambda::Client)

  sig { params(function_name: String, term: Term).void }
  def self.invoke_for_term(function_name, term)
    Rails.logger.info "Invoking for #{term.readable}"
    payload = construct_payload(term)
    invoke_function(function_name, payload)
  end

  sig { params(term: Term).returns(T::Hash[Symbol, T.untyped]) }
  def self.construct_payload(term)
    {
      term: {
        id: term.id,
        term: term.term,
      },
      shouldInsertEnrollmentData: false,
    }
  end

  sig { params(function_name: String, payload: T::Hash[Symbol, T.untyped]).void }
  def self.invoke_function(function_name, payload)
    response = @client.invoke({
                                function_name:,
                                log_type: 'Tail',
                                payload: JSON.generate(payload),
                              })
    logs = Base64.decode64(response.log_result)
    Rails.logger.info "\n#{logs}"
  end
end
