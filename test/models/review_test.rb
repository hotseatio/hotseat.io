# typed: strict
# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  it 'accepts organization ratings only between 1 and 7' do
    valid_review = build :review, organization: 5
    assert_equal(valid_review.valid?, true)

    invalid_review = build :review, organization: -11
    assert_equal(invalid_review.valid?, false)
  end

  it 'accepts clarity ratings only between 1 and 7' do
    valid_review = build :review, clarity: 1
    assert_equal(valid_review.valid?, true)

    invalid_review = build :review, clarity: 100
    assert_equal(invalid_review.valid?, false)
  end

  it 'accepts overall ratings only between 1 and 7' do
    valid_review = build :review, overall: 7
    assert_equal(valid_review.valid?, true)

    invalid_review = build :review, overall: 8
    assert_equal(invalid_review.valid?, false)
  end
end
