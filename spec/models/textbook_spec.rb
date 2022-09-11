# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Textbook, type: :model do
  describe 'sublabel' do
    it 'returns the edition and required status of the book if both are present' do
      textbook = build :textbook, edition: 4, is_required: true
      expect(textbook.sublabel).to eq '4th edition (Required)'
    end

    it 'returns the edition if the requirement status of the book is unclear' do
      textbook = build :textbook, edition: 4
      expect(textbook.sublabel).to eq '4th edition'
    end

    it 'returns the requirement status if the edition of the book is unclear' do
      textbook = build :textbook, is_required: false
      expect(textbook.sublabel).to eq 'Optional'
    end

    it 'returns the author if no edition or requirement info is provided' do
      textbook = build :textbook, author: 'Rogawski'
      expect(textbook.sublabel).to eq 'Rogawski'
    end

    it 'returns empty string if no info is provided' do
      textbook = build :textbook
      expect(textbook.sublabel).to be_empty
    end
  end

  describe 'amazon_link' do
    it 'returns a link to a product page if an isbn10 exists for the book' do
      textbook = build :textbook, isbn: '9781429208390'
      expect(textbook.amazon_link).to eq 'https://www.amazon.com/gp/product/1429208392?tag=hotseat0c-20'
    end

    it 'returns a link to search results if no isbn 10 exists' do
      textbook = build :textbook, isbn: '9798655930292'
      expect(textbook.amazon_link).to eq 'https://www.amazon.com/s/ref=as_li_ss_tl?k=9798655930292&tag=hotseat0c-20'
    end
  end
end
