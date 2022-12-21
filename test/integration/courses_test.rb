# typed: strict
# frozen_string_literal: true

require "test_helper"

class CoursesTest < ActionDispatch::IntegrationTest
  describe "GET /courses" do
    it "returns http success" do
      create_current_term
      get "/courses"
      assert_response :ok
    end
  end

  describe "GET /courses/:id" do
    it "redirects to the most recent instructor's page if there is an instructor" do
      # path = T.let(nil, T.nilable(String))
      term = create_current_term
      prev_term = create(:term)

      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      course = create(:course, subject_area: com_sci, title: "Introduction to the Beep Boop", number: 69)
      current_instructor = create(:instructor)
      prev_instructor = create(:instructor)
      create(:section, course:, term:, instructor: current_instructor)
      create(:section, course:, term: prev_term, instructor: prev_instructor)

      get "/courses/#{course.id}"
      assert_response :found
      follow_redirect!
      assert_equal "/courses/#{course.id}/instructors/#{current_instructor.id}", request.path
    end

    it "does not redirect if there is no instructor" do
      create_current_term

      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      course = create(:course, subject_area: com_sci, title: "Introduction to the Beep Boop", number: 69)

      get "/courses/#{course.id}"
      assert_response :ok
    end
  end
end
