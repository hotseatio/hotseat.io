# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SubjectAreas', type: :request do
  describe 'GET /subject-areas' do
    it 'lists all subject areas' do
      create_current_term
      create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      create(:subject_area, name: 'Communication', code: 'COMM')

      get '/subject-areas'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Subject Areas')
      expect(response.body).to include('Computer Science')
      expect(response.body).to include('Communication')
      expect(response.body).to have_selector('.pagination-info', content: 'Displaying all 2 subject areas')
    end
  end

  describe 'GET /subject-areas/:id' do
    it 'lists only the current courses of a subject area' do
      term = create_current_term
      subject_area = create(:subject_area, name: 'Computer Science', code: 'COM SCI', id: 42)
      create_list :course, 51, subject_area: subject_area
      current_course = create :course, subject_area: subject_area
      create :section, course: current_course, term: term

      get '/subject-areas/42'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Computer Science')
      expect(response.body).to have_selector('.pagination-info', content: 'Showing 1 course')
    end

    it 'lists all the courses of a subject area when given filter=all' do
      create_current_term
      subject_area = create(:subject_area, name: 'Computer Science', code: 'COM SCI', id: 42)
      create_list :course, 51, subject_area: subject_area

      get '/subject-areas/42?filter=all'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Computer Science')
      expect(response.body).to have_selector('.pagination-info', content: 'Showing 1 to 50 of 51 courses')
    end
  end
end
