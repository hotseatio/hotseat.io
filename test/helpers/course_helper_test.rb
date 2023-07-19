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

      assert_equal("4 sections", course_badge_label(Course.with_section_counts.first))
    end

    it "returns 'Not Offered' if the course is not offered" do
      create_current_term
      course = create(:course, subject_area: create(:subject_area))
      create_list(:section, 4, course:, term: create(:term, term: "20F"), instructor: create(:instructor))

      assert_equal("Not offered", course_badge_label(Course.with_section_counts.first))
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

  describe "#course_detail_label" do
    describe "has_group_project" do
      it "returns the correct string when the course has a group project" do
        course_detail = {
          label: :has_group_project,
          value: true,
        }
        assert_equal("Has a group project", course_detail_label(course_detail))
      end

      it "returns the correct string when the course does not have a group project" do
        course_detail = {
          label: :has_group_project,
          value: false,
        }
        assert_equal("No group projects", course_detail_label(course_detail))
      end
    end

    describe "requires_attendance" do
      it "returns the correct string when the course requires attendance" do
        course_detail = {
          label: :requires_attendance,
          value: true,
        }
        assert_equal("Attendance required", course_detail_label(course_detail))
      end

      it "returns the correct string when the course does not require attendance" do
        course_detail = {
          label: :requires_attendance,
          value: false,
        }
        assert_equal("Attendance not required", course_detail_label(course_detail))
      end
    end

    describe "final" do
      it "returns the correct string when a course has a finals week final" do
        course_detail = {
          label: :final,
          value: "finals",
        }
        assert_equal("Finals week final", course_detail_label(course_detail))
      end

      it "returns the correct string when a course has a 10th week final" do
        course_detail = {
          label: :final,
          value: "10th",
        }
        assert_equal("10th week final", course_detail_label(course_detail))
      end

      it "returns the correct string when a course does not have a final" do
        course_detail = {
          label: :final,
          value: "none",
        }
        assert_equal("No final", course_detail_label(course_detail))
      end
    end

    describe "midterm_count" do
      it "returns 'no midterms' for a course with no midterms" do
        course_detail = {
          label: :midterm_count,
          value: 0,
        }
        assert_equal("No midterms", course_detail_label(course_detail))
      end

      it "does not pluralize a single midterm" do
        course_detail = {
          label: :midterm_count,
          value: 1,
        }
        assert_equal("1 midterm", course_detail_label(course_detail))
      end

      it "pluralizes multiple midterms" do
        course_detail = {
          label: :midterm_count,
          value: 2,
        }
        assert_equal("2 midterms", course_detail_label(course_detail))
      end
    end

    describe "reccomend_textbook" do
      it "returns a string if the value is true" do
        course_detail = {
          label: :reccomend_textbook,
          value: true,
        }
        assert_equal("Recommends textbook", course_detail_label(course_detail))
      end

      it "returns a string if the value is false" do
        course_detail = {
          label: :reccomend_textbook,
          value: false,
        }
        assert_equal("Does not recommend textbook", course_detail_label(course_detail))
      end

      it "returns a percentage if given a number" do
        course_detail = {
          label: :reccomend_textbook,
          value: 65,
        }
        assert_equal("65% recommend the textbook", course_detail_label(course_detail))
      end
    end
  end
end
