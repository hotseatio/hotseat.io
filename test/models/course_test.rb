# typed: strict
# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  before do
    create :term
  end

  describe 'offered for term' do
    it 'returns true if the course is offered during the term' do
      term = build(:term)
      course = build(:course, terms: [term])
      assert(course.offered_for_term?(term))
    end

    it 'returns false if the course not is offered during the term' do
      term = build(:term)
      course = build(:course, terms: [])
      assert_not(course.offered_for_term?(term))
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
      assert_equal(expected_order, Course.all.order_by_number.map(&:number))
    end
  end

  describe 'catalog number' do
    it 'pads a course number with leading zeroes' do
      course = build(:course, number: '136')
      assert_equal('0136', course.catalog_number)
    end

    it 'puts the leading characters at the end' do
      course = build(:course, number: 'M117')
      assert_equal('0117  M', course.catalog_number)
    end

    it 'puts the trailing characters after the number' do
      course = build(:course, number: '460AW')
      assert_equal('0460AW', course.catalog_number)
    end

    it 'can handle both leading and trailing characters' do
      course = build(:course, number: 'M151B')
      assert_equal('0151B M', course.catalog_number)
    end

    it "can handle numbers like 'Z'" do
      course = build(:course, number: 'Z')
      assert_equal('0000Z', course.catalog_number)
    end
  end
end
