# typed: false
# frozen_string_literal: true

RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    format = '%Y-%m-%d %H:%M:%S %Z'
    expect(expected.strftime(format)).to eq(actual.strftime(format))
  end
end
