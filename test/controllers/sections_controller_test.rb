# typed: strict
# frozen_string_literal: true

require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /enroll/:id" do
    it "redirects to the MyUCLA page for a section" do
      term = create(:term)
      subject_area = create(:subject_area)
      course = create(:course, subject_area:)
      section = create(:section, term:, course:)
      get "/enroll/#{section.id}"

      query_params = {
        t: term.term,
        sBy: "subject",
        subj: course.subject_area_code,
        crsCatlg: "#{course.number} - #{course.title}",
        catlg: course.catalog_number,
        cls_no: "%",
      }

      assert_response :found
      assert_redirected_to "https://sa.ucla.edu/ro/ClassSearch/Results?#{query_params.to_query}"
    end
  end
end
