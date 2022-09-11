# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'GET /reviews/new' do
    it 'redirects to login if a user is not authenticated' do
      create_current_term
      get '/reviews/new'
      expect(response).to redirect_to '/sign_in'
    end

    it 'loads the review form without a pre-filled course' do
      create_current_term
      sign_in create(:user)
      get '/reviews/new'

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_selector('#ReviewForm')
    end
  end

  describe 'GET /reviews/course-suggestions' do
    it 'suggests courses given search text', search: true do
      create_current_term
      sign_in create(:user)
      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      create(:course, :reindex, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: '30', id: 69)

      get '/reviews/course-suggestions?q=com+sci'

      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to be 1
      expect(parsed_body.first).to eq({
                                        'id' => 69,
                                        'title' => 'Introduction to the Beep Boop',
                                        'number' => '30',
                                        'subjectAreaCode' => 'COM SCI',
                                      })
    end
  end

  describe 'GET /reviews/term-suggestions' do
    it 'provides the terms a given course has been offered under' do
      create_current_term
      sign_in create(:user)
      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      preceding_course = create(:course, subject_area: com_sci, title: 'Introduction to the Boop Beep', number: '30', id: 68)
      course = create(:course, subject_area: com_sci,
                               title: 'Introduction to the Beep Boop',
                               number: '30',
                               id: 69,
                               preceding_course:)
      create_list(:section, 6, course:)

      get "/reviews/term-suggestions?course_id=#{course.id}"

      expect(response).to have_http_status(:ok)

      parsed_body = JSON.parse(response.body)
      expect(parsed_body['terms'].length).to be 6
      expect(parsed_body['precedingCourse']).to match({
                                                        'subjectAreaCode' => 'COM SCI',
                                                        'title' => 'Introduction to the Boop Beep',
                                                        'number' => '30',
                                                        'id' => 68,
                                                      })
      expect(parsed_body['supersedingCourse']).to be_nil
    end
  end

  describe 'POST /reviews' do
    review = {
      grade: 'A+',
      organization: '7',
      clarity: '7',
      overall: '7',
      weekly_time: '5-10',
      group_project: 'false',
      attendance: 'false',
      extra_credit: 'false',
      midterm_count: '1',
      final: '10th',
      textbook: 'true',
      comments: 'Labore anim veniam adipiscing, non. Adipiscing non eu, et sunt sunt. Et sunt sunt minim amet culpa aliqua. Sunt minim amet culpa aliqua, cupidatat. Culpa aliqua cupidatat nulla dolor elit ex exercitation. Cupidatat nulla dolor elit ex exercitation.',
    }
    let(:term) { create_current_term }
    let(:user) {  create(:user) }
    let(:section) do
      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      course = create(:course, subject_area: com_sci,
                               title: 'Introduction to the Beep Boop',
                               number: '30',
                               id: 69)
      create(:section, course:, term:)
    end

    before do
      sign_in user
    end

    it 'creates a new review' do
      post '/reviews', params: {
        review: { **review, section_id: section.id },
      }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(my_courses_path)
    end

    it 'returns an error if a user has already written 6 reviews for a quarter' do
      create_list(:section, 6, term:) do |section|
        create(:review, user:, section:)
      end
      post '/reviews', params: {
        review: {
          **review,
          section_id: section.id,
        },
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body['msg']).to eq 'You can only review six classes per term.'
    end

    it 'returns an error if the course was reviewed already' do
      post '/reviews', params: {
        review: {
          **review,
          section_id: section.id,
        },
      }
      post '/reviews', params: {
        review: {
          **review,
          section_id: section.id,
        },
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body['msg']).to eq "You've already reviewed this course."
    end

    it 'returns an error if the comments are too short' do
      post '/reviews', params: {
        review: {
          **review,
          comments: 'class is good',
          section_id: section.id,
        },
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body['msg']).to eq 'Your review looks a little short. Tell us a bit more about the class!'
    end

    it 'returns an error if the comments are gibberish' do
      post '/reviews', params: {
        review: {
          **review,
          comments: 'Labore anim veniam adipiscing, non. tdairhbunwdkccbuahnubk ahrbxuihubhkxtbmitnt ihdiccauxbruri.',
          section_id: section.id,
        },
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body['msg']).to eq 'We had trouble understanding your review. Please make sure everything looks correct!'
    end
  end
end
