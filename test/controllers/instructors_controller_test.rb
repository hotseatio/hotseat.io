# typed: strict
# frozen_string_literal: true

require "test_helper"

class InstructorsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /instructors" do
    it "returns a paginated list of all instructors" do
      create_current_term
      create_list(:instructor, 10)
      create(:instructor, first_names: ["Mark"], last_names: ["Huppin"])
      create(:instructor, first_names: ["Paul"], last_names: ["Eggert"])

      get "/instructors"

      assert_response :ok
      assert_select "h2", "Instructors"

      assert_select "p", "Mark Huppin"
      assert_select "p", "Paul Eggert"
      assert_select ".pagination-info", "Displaying all 12 instructors"
    end
  end

  describe "GET /instructors/:id" do
    it "returns info on the specified instructor" do
      create_current_term
      instructor = create(:instructor, first_names: ["Mark"], last_names: ["Huppin"])

      get "/instructors/#{instructor.id}"

      assert_response :ok
      assert_select "h2", "Mark Huppin"
      assert_select "h3", "Review Summary"
      assert_select "h3", "Courses"
    end
  end
end
