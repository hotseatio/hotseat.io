# typed: strict
# frozen_string_literal: true

require "test_helper"

class SearchTest < ActionDispatch::IntegrationTest
  before do
    # Reindex models, since every test happens in a transaction
    T.unsafe(Course).reindex
    T.unsafe(Instructor).reindex

    Searchkick.enable_callbacks
  end

  after do
    Searchkick.disable_callbacks
  end

  describe "GET /search", search: true do
    it "returns no results without a query" do
      create_current_term
      get "/search"

      assert_response :ok
      assert_select "p", "No results found"
    end

    it "returns results when given a query" do
      create_current_term
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      comm = create(:subject_area, name: "Communication", code: "COMM")
      create(:course, :reindex, subject_area: com_sci, title: "Introduction to the Beep Boop", number: 10)
      create(:course, :reindex, subject_area: com_sci, title: "Graduate Beep Boop", number: 222)
      create(:course, :reindex, subject_area: comm, title: "Intro to Comm", number: 10)

      get "/search?q=com+sci"

      assert_response :ok
      assert_select "p", "COM SCI 10"
      assert_select "p", "Introduction to the Beep Boop"
      assert_select "p", { count: 0, text: "COMM 10" }
      assert_select "p", { count: 0, text: "Intro to Comm" }
      assert_select ".pagination-info", "Displaying all 2 results"
    end
  end

  describe "GET /suggestions", search: true do
    it "raise error without query" do
      assert_raises ActionController::BadRequest do
        get "/search/suggestions"
      end
    end

    it "returns no suggestions with q=" do
      get "/search/suggestions?q="
      assert_response :ok
      parsed_body = response.parsed_body
      assert_empty parsed_body
    end

    it "returns suggestions with q=com+sci" do
      create_current_term
      subject_area = create(:subject_area, code: "COM SCI")
      create(:course, :reindex,
             subject_area:,
             number: "30",
             title: "Introduction to Computer Science 0")
      create_list(:course, 10, :reindex, subject_area:)

      get "/search/suggestions?q=com+sci"
      assert_response :ok
      parsed_body = response.parsed_body
      assert_equal 8, parsed_body.length

      first_result = parsed_body.first["searchable"]

      assert_match(/^Course/, parsed_body.first["id"])
      assert_equal "Course", parsed_body.first["searchableType"]

      assert_instance_of(Integer, first_result["id"])
      assert_instance_of(String, first_result["number"])
      assert_equal("COM SCI", first_result["subjectAreaCode"])
      assert_match(%r{^/courses/}, first_result["linkUrl"])
      assert_match(/^Introduction to Computer Science/, first_result["title"])
    end

    it "returns no suggestions with q=adsfasdfasfd" do
      subject_area = create(:subject_area, code: "COM SCI")
      create_list(:course, 10, :reindex, subject_area:)
      get "/search/suggestions?q=adsfasdfasfd"
      assert_response :ok
      parsed_body = response.parsed_body
      assert_empty parsed_body
    end
  end
end
