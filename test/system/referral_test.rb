# typed: strict
# frozen_string_literal: true

require "application_system_test_case"

class ReferralTest < ApplicationSystemTestCase
  sig { void }
  def fill_out_review
    within("#term") do
      click_button
      within("ul") do
        find("li", text: "Winter 2020").click
      end
    end

    within("#section") do
      click_button
      within("ul") do
        find("li", text: "Lecture 1: Paul Eggert (MW at 10am-11:50am)").click
      end
    end

    within("#grade") do
      click_button
      within("ul") do
        find("li", text: "A+").click
      end
    end

    within("#organization") do
      choose("Somewhat agree")
    end
    within("#clarity") do
      choose("Strongly agree")
    end
    within("#overall") do
      choose("Disagree")
    end
    within("#weekly_time") do
      choose("15-20 hrs/week")
    end
    within("#group_project") do
      choose("Yes")
    end
    within("#attendance") do
      choose("No")
    end
    within("#extra_credit") do
      choose("No")
    end
    within("#midterm_count") do
      choose("2")
    end
    within("#final") do
      choose("Yes, during finals week")
    end
    within("#textbook") do
      choose("Yes")
    end

    review_text = Faker::Lorem.paragraph
    fill_in("review[comments]", with: review_text)

    click_button("Publish review")
  end

  test "user fills out a review after being referred" do
    create_current_term

    referring_user = create(:user, name: "Nathan Smith", notification_token_count: 100)
    user = create(:user, referred_by: referring_user, notification_token_count: 1)

    subj_area = create(:subject_area)
    section = create(:section,
                     course: create(:course,
                                    subject_area: subj_area),
                     term: create(:term, term: "20W"),
                     instructor: create(:instructor, first_names: ["Paul"], last_names: ["Eggert"]))

    sign_in user
    assert_equal 1, user.notification_token_count
    visit "/reviews/new?course=#{section.course_id}"

    fill_out_review

    assert_current_path "/my-courses"
    assert_text page, "Review submitted! Since you were referred by Nathan Smith, you'll receive 2 notification tokens once your review is approved. (We'll text you when that happens!)", wait: 10

    # No tokens yet
    referring_user.reload
    user.reload
    assert_equal(100, referring_user.notification_token_count)
    assert_equal(1, user.notification_token_count)

    # TODO: add review.approve! to check what happens after the review is approved.
    #
    # review = ...
    # review.approve!
    #
    # referring_user.reload
    # user.reload
    # # +1 token for the referrer
    # assert_equal(101, referring_user.notification_token_count)
    # # +2 token for the referree
    # assert_equal(3, user.notification_token_count)
  end
end
