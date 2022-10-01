# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'accepts organization ratings only between 1 and 7' do
    valid_review = build :review, organization: 5
    expect(valid_review.valid?).to be true

    invalid_review = build :review, organization: -11
    expect(invalid_review.valid?).to be false
  end

  it 'accepts clarity ratings only between 1 and 7' do
    valid_review = build :review, clarity: 1
    expect(valid_review.valid?).to be true

    invalid_review = build :review, clarity: 100
    expect(invalid_review.valid?).to be false
  end

  it 'accepts overall ratings only between 1 and 7' do
    valid_review = build :review, overall: 7
    expect(valid_review.valid?).to be true

    invalid_review = build :review, overall: 8
    expect(invalid_review.valid?).to be false
  end
end
