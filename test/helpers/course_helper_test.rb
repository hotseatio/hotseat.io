# typed: strict
# frozen_string_literal: true

require "test_helper"

class CourseHelperTest < ActionView::TestCase
  include CourseHelper

  describe "course_badge_label" do
    it "returns the number of sections for an offered course" do
      term = create_current_term
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term:, instructor: create(:instructor))

      assert_equal("4 sections", course_badge_label(T.must(Course.with_section_counts.first)))
    end

    it "returns 'Not Offered' if the course is not offered" do
      create_current_term
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term: create(:term, term: "20F"), instructor: create(:instructor))

      assert_equal("Not offered", course_badge_label(T.must(Course.with_section_counts.first)))
    end

    it "returns nil if the course does not have a section count" do
      term = create(:term)
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term:, instructor: create(:instructor))

      assert_nil(course_badge_label(course))
    end
  end

  describe "course_badge_color" do
    it "returns gray if the course is not offered" do
      assert_equal(ColorHelper::Color::Gray, course_badge_color("Not offered"))
    end

    it "returns green if the course is offered" do
      assert_equal(ColorHelper::Color::Green, course_badge_color("3 sections"))
    end

    it "returns nil if given nil" do
      assert_nil(course_badge_color(nil))
    end
  end
end
