# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'WriteReviews', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'allows users to write reviews with course preloaded' do
    allow(NotifyOnNewReviewJob).to receive(:perform_later)
    create_current_term
    subj_area = create(:subject_area)
    section = create :section,
                     course: create(:course,
                                    subject_area: subj_area),
                     term: create(:term, term: '20W'),
                     instructor: create(:instructor, first_names: ['Paul'], last_names: ['Eggert'])

    sign_in create(:user)
    visit "/reviews/new?course=#{section.course_id}"

    within '#term' do
      click_button
      within 'ul' do
        find('li', text: 'Winter 2020').click
      end
    end

    within '#section' do
      click_button
      within 'ul' do
        find('li', text: 'Lecture 1: Paul Eggert (MW at 10am-11:50am)').click
      end
    end

    within '#grade' do
      click_button
      within 'ul' do
        find('li', text: 'A+').click
      end
    end

    within '#organization' do
      choose('Somewhat agree')
    end
    within '#clarity' do
      choose('Strongly agree')
    end
    within '#overall' do
      choose('Disagree')
    end
    within '#weekly_time' do
      choose('15-20 hrs/week')
    end
    within '#group_project' do
      choose('Yes')
    end
    within '#attendance' do
      choose('No')
    end
    within '#extra_credit' do
      choose('No')
    end
    within '#midterm_count' do
      choose('2')
    end
    within '#final' do
      choose('Yes, during finals week')
    end
    within '#textbook' do
      choose('Yes')
    end

    review_text = Faker::Lorem.paragraph
    fill_in 'review[comments]', with: review_text

    click_button 'Publish review'

    expect(page).to have_current_path('/my-courses')
    # TODO(475): GitHub Actions are being weird about session variables, so the flash doesn't always appear
    expect(page).to have_content 'Review created!' unless ENV['CI'] == 'true'

    review = section.reviews.first
    expect(review.a_plus?).to be true
    expect(review.organization).to be 5
    expect(review.clarity).to be 7
    expect(review.overall).to be 2
    expect(review.fifteen_to_twenty_hours?).to be true
    expect(review.has_group_project).to be true
    expect(review.requires_attendance).to be false
    expect(review.midterm_count).to be 2
    expect(review.finals_week?).to be true
    expect(review.reccomend_textbook).to be true
    expect(review.offers_extra_credit).to be false
    expect(review.comments).to eq review_text
    expect(NotifyOnNewReviewJob).to have_received(:perform_later)
  end

  it 'allows users to write reviews with section preloaded' do
    allow(NotifyOnNewReviewJob).to receive(:perform_later)
    create_current_term
    subj_area = create(:subject_area)
    section = create :section,
                     course: create(:course,
                                    subject_area: subj_area),
                     term: create(:term, term: '20W'),
                     instructor: create(:instructor, first_names: ['Paul'], last_names: ['Eggert'])

    sign_in create(:user)
    visit "/reviews/new?section=#{section.id}"

    within '#grade' do
      click_button
      within 'ul' do
        find('li', text: 'A+').click
      end
    end

    within '#organization' do
      choose('Somewhat agree')
    end
    within '#clarity' do
      choose('Strongly agree')
    end
    within '#overall' do
      choose('Disagree')
    end
    within '#weekly_time' do
      choose('15-20 hrs/week')
    end
    within '#attendance' do
      choose('No')
    end
    within '#group_project' do
      choose('Yes')
    end
    within '#extra_credit' do
      choose('No')
    end
    within '#midterm_count' do
      choose('2')
    end
    within '#final' do
      choose('Yes, during finals week')
    end
    within '#textbook' do
      choose('Yes')
    end

    review_text = Faker::Lorem.paragraph
    fill_in 'review[comments]', with: review_text

    click_button 'Publish review'

    expect(page).to have_current_path('/my-courses')
    # TODO(475): GitHub Actions are being weird about session variables, so the flash doesn't always appear
    expect(page).to have_content 'Review created!' unless ENV['CI'] == 'true'

    review = section.reviews.first
    expect(review.a_plus?).to be true
    expect(review.organization).to be 5
    expect(review.clarity).to be 7
    expect(review.overall).to be 2
    expect(review.fifteen_to_twenty_hours?).to be true
    expect(review.has_group_project).to be true
    expect(review.requires_attendance).to be false
    expect(review.midterm_count).to be 2
    expect(review.finals_week?).to be true
    expect(review.reccomend_textbook).to be true
    expect(review.offers_extra_credit).to be false
    expect(review.comments).to eq review_text
    expect(NotifyOnNewReviewJob).to have_received(:perform_later)
  end
end
