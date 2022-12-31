# typed: strict
# frozen_string_literal: true

require "test_helper"

class ReviewsTest < ActionDispatch::IntegrationTest
  REVIEW = T.let({
    grade: "A+",
    organization: "7",
    clarity: "7",
    overall: "7",
    weekly_time: "5-10",
    group_project: "false",
    attendance: "false",
    extra_credit: "false",
    midterm_count: "1",
    final: "10th",
    textbook: "true",
    comments: "Labore anim veniam adipiscing, non. Adipiscing non eu, et sunt sunt. Et sunt sunt minim amet culpa aliqua. Sunt minim amet culpa aliqua, cupidatat. Culpa aliqua cupidatat nulla dolor elit ex exercitation. Cupidatat nulla dolor elit ex exercitation.",
  }.freeze, T::Hash[Symbol, String])

  describe "GET /reviews/new" do
    it "redirects to login if a user is not authenticated" do
      create_current_term
      get "/reviews/new"
      assert_redirected_to "/sign_in"
    end

    it "loads the review form without a pre-filled course" do
      create_current_term
      sign_in create(:user)
      get "/reviews/new"

      assert_response :ok
      assert_select "#ReviewForm"
    end
  end

  describe "GET /reviews/course-suggestions" do
    before do
      # Reindex models, since every test happens in a transaction
      T.unsafe(Course).reindex
      T.unsafe(Instructor).reindex

      Searchkick.enable_callbacks
    end

    after do
      Searchkick.disable_callbacks
    end

    it "suggests courses given search text" do
      create_current_term
      sign_in create(:user)
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      create(:course, :reindex, subject_area: com_sci, title: "Introduction to the Beep Boop", number: "30", id: 5)

      get "/reviews/course-suggestions?q=com+sci"

      assert_response :ok
      parsed_body = JSON.parse(response.body)
      assert_equal 1, parsed_body.length
      assert_equal({
                     "id" => 5,
                     "title" => "Introduction to the Beep Boop",
                     "number" => "30",
                     "subjectAreaCode" => "COM SCI",
                   }, parsed_body.first)
    end
  end

  describe "GET /reviews/term-suggestions" do
    it "provides the terms a given course has been offered under" do
      create_current_term
      sign_in create(:user)
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      preceding_course = create(:course, subject_area: com_sci, title: "Introduction to the Boop Beep", number: "30", id: 5)
      course = create(:course, subject_area: com_sci,
                               title: "Introduction to the Beep Boop",
                               number: "30",
                               id: 6,
                               preceding_course:)
      create_list(:section, 6, course:)
      get "/reviews/term-suggestions?course_id=#{course.id}"

      assert_response :ok

      assert_equal 6, response.parsed_body["terms"].length
      assert_equal({
                     "subjectAreaCode" => "COM SCI",
                     "title" => "Introduction to the Boop Beep",
                     "number" => "30",
                     "id" => 5,
                   }, response.parsed_body["precedingCourse"])
      assert_nil(response.parsed_body["supersedingCourse"])
    end
  end

  describe "GET /reviews/section-suggestions" do
    it "provides the sections for a given term and course" do
      term = create_current_term
      sign_in create(:user)
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      course = create(:course, subject_area: com_sci,
                               title: "Introduction to the Beep Boop",
                               number: "30",
                               id: 6)
      create_list(:section, 6, course:, term:)
      get "/reviews/section-suggestions?course_id=#{course.id}&term=#{term.term}"

      assert_response :ok
      assert_equal 6, response.parsed_body.length
    end
  end

  describe "POST /reviews" do
    before do
      @term = T.let(create_current_term, Term)
      @user = T.let(create(:user), User)
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      course = create(:course, subject_area: com_sci,
                               title: "Introduction to the Beep Boop",
                               number: "30",
                               id: 69)
      @section = T.let(create(:section, course:, term: @term), Section)

      sign_in @user
    end

    it "creates a new review" do
      post "/reviews", params: {
        review: { **REVIEW, section_id: @section.id },
      }
      assert_response :found
      assert_redirected_to(my_courses_path)
    end

    it "returns an error if a user has already written 6 reviews for a quarter" do
      create_list(:section, 6, term: @term) do |section|
        create(:review, user: @user, section:)
      end
      post "/reviews", params: {
        review: {
          **REVIEW,
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "You can only review six classes per term.", response.parsed_body["msg"]
    end

    it "returns an error if the course was reviewed already" do
      post "/reviews", params: {
        review: {
          **REVIEW,
          section_id: @section.id,
        },
      }
      post "/reviews", params: {
        review: {
          **REVIEW,
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "You've already reviewed this course.", response.parsed_body["msg"]
    end

    it "returns an error if the comments are too short" do
      post "/reviews", params: {
        review: {
          **REVIEW,
          comments: "class is good",
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "Your review looks a little short. Tell us a bit more about the class!", response.parsed_body["msg"]
    end

    it "returns an error if the comments are gibberish" do
      post "/reviews", params: {
        review: {
          **REVIEW,
          comments: "Labore anim veniam adipiscing, non. tdairhbunwdkccbuahnubk ahrbxuihubhkxtbmitnt ihdiccauxbruri.",
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "We had trouble understanding your review. Please make sure everything looks correct!", response.parsed_body["msg"]
    end
  end

  describe "GET /reviews/:id/edit" do
    before do
      @term = T.let(create_current_term, Term)
      @user = T.let(create(:user), User)
      @review = T.let(create(:review, user: @user), Review)
    end

    it "redirects to login if a user is not authenticated" do
      get "/reviews/#{@review.id}/edit"
      assert_redirected_to "/sign_in"
    end

    it "redirects back if a user is not the author" do
      sign_in create(:user)
      get "/reviews/#{@review.id}/edit"
      assert_redirected_to "/my-courses"
    end

    it "loads the review form with the review prefilled" do
      sign_in @user
      get "/reviews/#{@review.id}/edit"

      assert_response :ok
      assert_select "#ReviewForm"
    end
  end

  describe "PUT/PATCH /reviews/:id" do
    before do
      @term = T.let(create_current_term, Term)
      @user = T.let(create(:user), User)
      com_sci = create(:subject_area, name: "Computer Science", code: "COM SCI")
      course = create(:course, subject_area: com_sci,
                               title: "Introduction to the Beep Boop",
                               number: "30",
                               id: 69)
      @section = T.let(create(:section, course:, term: @term), Section)

      sign_in @user
    end

    it "successfully edits a review" do
      review = T.let(create(
                       :review,
                       section: @section,
                       user: @user,
                       organization: "1",
                       clarity: "1",
                       overall: "1",
                     ), Review)

      patch "/reviews/#{review.id}", params: {
        review: {
          **REVIEW,
          organization: "5",
          clarity: "5",
          overall: "5",
          comments: "Upon reflection, this course was actually a lot better than I originally said. I learned a ton that prepared me for upper-divs.",
          section_id: @section.id,
        },
      }

      assert_response :see_other
      assert_redirected_to(my_courses_path)
    end

    it "returns an error if the user didn't write the review" do
      other_user = T.let(create(:user), User)
      review = T.let(create(:review, section: @section, user: other_user), Review)
      patch "/reviews/#{review.id}", params: {
        review: {
          **REVIEW,
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "You can't edit a review that isn't yours.", response.parsed_body["msg"]
    end

    it "returns an error if a user has already written 6 reviews for a quarter" do
      review = T.let(create(:review, user: @user), Review)
      create_list(:section, 6, term: @term) do |section|
        create(:review, user: @user, section:)
      end
      patch "/reviews/#{review.id}", params: {
        review: {
          **REVIEW,
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "You can only review six classes per term.", response.parsed_body["msg"]
    end

    it "returns an error if the comments are too short" do
      review = T.let(create(:review, user: @user, section: @section), Review)
      patch "/reviews/#{review.id}", params: {
        review: {
          **REVIEW,
          comments: "class is good",
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "Your review looks a little short. Tell us a bit more about the class!", response.parsed_body["msg"]
    end

    it "returns an error if the comments are gibberish" do
      review = T.let(create(:review, section: @section, user: @user), Review)
      patch "/reviews/#{review.id}", params: {
        review: {
          **REVIEW,
          comments: "Labore anim veniam adipiscing, non. tdairhbunwdkccbuahnubk ahrbxuihubhkxtbmitnt ihdiccauxbruri.",
          section_id: @section.id,
        },
      }
      assert_response :bad_request
      assert_equal "We had trouble understanding your review. Please make sure everything looks correct!", response.parsed_body["msg"]
    end
  end
end
