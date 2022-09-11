# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseHelper, type: :helper do
  describe 'course_badge_label' do
    it 'returns the number of sections for an offered course' do
      term = create_current_term
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term:, instructor: create(:instructor))

      expect(helper.course_badge_label(Course.with_section_counts.first)).to eq('4 sections')
    end

    it "returns 'Not Offered' if the course is not offered" do
      create_current_term
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term: create(:term, term: '20F'), instructor: create(:instructor))

      expect(helper.course_badge_label(Course.with_section_counts.first)).to eq('Not offered')
    end

    it 'returns nil if the course does not have a section count' do
      term = create(:term)
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term:, instructor: create(:instructor))

      expect(helper.course_badge_label(course)).to be_nil
    end
  end

  describe 'course_badge_color' do
    it 'returns gray if the course is not offered' do
      expect(helper.course_badge_color('Not offered')).to eq(ColorHelper::Color::Gray)
    end

    it 'returns green if the course is offered' do
      expect(helper.course_badge_color('3 sections')).to eq(ColorHelper::Color::Green)
    end

    it 'returns nil if given nil' do
      expect(helper.course_badge_color(nil)).to be_nil
    end
  end
end
