# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  include FactoryBot::Syntax::Methods

  before do
    create :term
  end

  describe 'offered for term' do
    it 'returns true if the course is offered during the term' do
      term = build(:term)
      course = build(:course, terms: [term])
      expect(course.offered_for_term?(term)).to be(true)
    end

    it 'returns false if the course not is offered during the term' do
      term = build(:term)
      course = build(:course, terms: [])
      expect(course.offered_for_term?(term)).to be(false)
    end
  end

  describe 'order by number' do
    it 'follows rules correctly' do
      expected_order = %w[A Z 151 151A M151A 151B M151B 152A M152A 152B M152B 152BW]
      creation_order = %w[151B M151A M152B 151 152A Z M152A 152B 152BW M151B A 151A]
      create(:subject_area) do |subject_area|
        creation_order.each do |number|
          create(:course, subject_area:, number:)
        end
      end
      expect(described_class.all.order_by_number.map(&:number)).to eq(expected_order)
    end
  end

  describe 'catalog number' do
    it 'pads a course number with leading zeroes' do
      course = build(:course, number: '136')
      expect(course.catalog_number).to eq('0136')
    end

    it 'puts the leading characters at the end' do
      course = build(:course, number: 'M117')
      expect(course.catalog_number).to eq('0117  M')
    end

    it 'puts the trailing characters after the number' do
      course = build(:course, number: '460AW')
      expect(course.catalog_number).to eq('0460AW')
    end

    it 'can handle both leading and trailing characters' do
      course = build(:course, number: 'M151B')
      expect(course.catalog_number).to eq('0151B M')
    end

    it "can handle numbers like 'Z'" do
      course = build(:course, number: 'Z')
      expect(course.catalog_number).to eq('0000Z')
    end
  end
end
