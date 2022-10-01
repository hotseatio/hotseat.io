# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses' do
    it 'returns http success' do
      create_current_term
      get '/courses'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /courses/:id' do
    it "redirects to the most recent instructor's page if there is an instructor" do
      term = create_current_term
      prev_term = create(:term)

      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      course = create(:course, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: 69)
      current_instructor = create(:instructor)
      prev_instructor = create(:instructor)
      create(:section, course:, term:, instructor: current_instructor)
      create(:section, course:, term: prev_term, instructor: prev_instructor)

      get "/courses/#{course.id}"
      expect(response).to have_http_status(:found)
      expect(response.headers['Location']).to eq "http://www.example.com/courses/#{course.id}/instructors/#{current_instructor.id}"
    end

    it 'does not redirect if there is no instructor' do
      create_current_term

      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      course = create(:course, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: 69)

      get "/courses/#{course.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
