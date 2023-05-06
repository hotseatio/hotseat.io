# typed: strict
# frozen_string_literal: true

require "application_system_test_case"

class ReviewsSystemTest < ApplicationSystemTestCase
  it "allows users to write reviews with course preloaded" do
    T.unsafe(NotifyOnNewReviewJob).expects(:perform_later)

    create_current_term
    subj_area = create(:subject_area)
    section = create(:section,
                     course: create(:course,
                                    subject_area: subj_area),
                     term: create(:term, term: "20W"),
                     instructor: create(:instructor, first_names: ["Paul"], last_names: ["Eggert"]))

    user = create(:user, notification_token_count: 0)
    sign_in user
    visit "/reviews/new?course=#{section.course_id}"

    within "#term" do
      click_button
      within "ul" do
        find("li", text: "Winter 2020").click
      end
    end

    within "#section" do
      click_button
      within "ul" do
        find("li", text: "Lecture 1: Paul Eggert (MW at 10am-11:50am)").click
      end
    end

    within "#grade" do
      click_button
      within "ul" do
        find("li", text: "A+").click
      end
    end

    within "#organization" do
      choose("Somewhat agree")
    end
    within "#clarity" do
      choose("Strongly agree")
    end
    within "#overall" do
      choose("Disagree")
    end
    within "#weekly_time" do
      choose("15-20 hrs/week")
    end
    within "#group_project" do
      choose("Yes")
    end
    within "#attendance" do
      choose("No")
    end
    within "#extra_credit" do
      choose("No")
    end
    within "#midterm_count" do
      choose("2")
    end
    within "#final" do
      choose("Yes, during finals week")
    end
    within "#textbook" do
      choose("Yes")
    end

    review_text = Faker::Lorem.paragraph
    fill_in "review[comments]", with: review_text

    click_button "Publish review"

    assert_current_path "/my-courses"
    assert_text page, "Review submitted! Once approved, you'll receive a notification token. (We'll text you when that happens!)", wait: 10

    review = section.reviews.first
    assert_predicate review, :a_plus?
    assert_equal 5, review.organization
    assert_equal 7, review.clarity
    assert_equal 2, review.overall
    assert_predicate review, :fifteen_to_twenty_hours?
    assert review.has_group_project
    assert_not review.requires_attendance
    assert_equal 2, review.midterm_count
    assert_predicate review, :finals_week?
    assert review.reccomend_textbook
    assert_not review.offers_extra_credit
    assert_equal review_text, review.comments

    user.reload
    assert_equal(0, user.notification_token_count)
  end

  it "allows users to write reviews with section preloaded" do
    T.unsafe(NotifyOnNewReviewJob).expects(:perform_later)
    create_current_term
    subj_area = create(:subject_area)
    section = create(:section,
                     course: create(:course,
                                    subject_area: subj_area),
                     term: create(:term, term: "20W"),
                     instructor: create(:instructor, first_names: ["Paul"], last_names: ["Eggert"]))

    user = create(:user, notification_token_count: 0)
    sign_in user
    visit "/reviews/new?section=#{section.id}"

    within "#grade" do
      click_button
      within "ul" do
        find("li", text: "A+").click
      end
    end

    within "#organization" do
      choose("Somewhat agree")
    end
    within "#clarity" do
      choose("Strongly agree")
    end
    within "#overall" do
      choose("Disagree")
    end
    within "#weekly_time" do
      choose("15-20 hrs/week")
    end
    within "#attendance" do
      choose("No")
    end
    within "#group_project" do
      choose("Yes")
    end
    within "#extra_credit" do
      choose("No")
    end
    within "#midterm_count" do
      choose("2")
    end
    within "#final" do
      choose("Yes, during finals week")
    end
    within "#textbook" do
      choose("Yes")
    end

    review_text = Faker::Lorem.paragraph
    fill_in "review[comments]", with: review_text

    click_button "Publish review"

    assert_current_path "/my-courses"

    review = section.reviews.first
    assert_predicate review, :a_plus?
    assert_equal 5, review.organization
    assert_equal 7, review.clarity
    assert_equal 2, review.overall
    assert_predicate review, :fifteen_to_twenty_hours?
    assert review.has_group_project
    assert_not review.requires_attendance
    assert_equal 2, review.midterm_count
    assert_predicate review, :finals_week?
    assert review.reccomend_textbook
    assert_not review.offers_extra_credit
    assert_equal review_text, review.comments
    assert_equal "pending", review.status

    user.reload
    assert_equal(0, user.notification_token_count)
  end

  describe "review editing" do
    before do
      create_current_term
      subj_area = create(:subject_area)
      section = create(:section,
                       course: create(:course,
                                      subject_area: subj_area),
                       term: create(:term, term: "20W"),
                       instructor: create(:instructor, first_names: ["Paul"], last_names: ["Eggert"]))
      @user = T.let(create(:user), User)
      @review = T.let(create(:review, user: @user, section:,
                                      organization: 4,
                                      clarity: 3,
                                      overall: 3,
                                      weekly_time: "10-15",
                                      grade: "C+",
                                      has_group_project: true,
                                      requires_attendance: false,
                                      reccomend_textbook: false,
                                      midterm_count: 2,
                                      final: "finals",
                                      offers_extra_credit: true), Review)
    end

    it "populates the field with the review" do
      sign_in @user
      visit "/reviews/#{@review.id}/edit"

      within "#grade" do
        assert_button(text: "C+")
      end

      within "#organization" do
        assert_checked_field("Neutral")
      end
      # within "#clarity" do
      #   assert_checked_field("Somewhat Disagree")
      # end
      # within "#overall" do
      #   assert_checked_field("Somewhat Disagree")
      # end
      # within "#weekly_time" do
      #   assert_checked_field("15-20 hrs/week")
      # end
      within "#attendance" do
        assert_checked_field("No")
      end
      within "#group_project" do
        assert_checked_field("Yes")
      end
      within "#extra_credit" do
        assert_checked_field("Yes")
      end
      within "#midterm_count" do
        assert_checked_field("2")
      end
      within "#final" do
        assert_checked_field("Yes, during finals week")
      end
      within "#textbook" do
        assert_checked_field("No")
      end
      assert_field "review[comments]", with: @review.comments
    end

    it "allows for changing the review" do
      sign_in @user
      @user.reload
      prev_tokens = @user.notification_token_count

      visit "/reviews/#{@review.id}/edit"
      review_text = "I've thought about my review some more and wanted to change what I wrote because I'm now taking another class that made me think about this professor in a new light!"

      fill_in "review[comments]", with: review_text

      click_button "Edit review"
      assert_current_path "/my-courses"

      @review.reload
      assert_equal(review_text, @review.comments)
      assert_equal("pending", @review.status)

      @user.reload
      assert_equal(prev_tokens, @user.notification_token_count)
    end
  end
end
