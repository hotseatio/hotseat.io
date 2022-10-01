# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :request do
  describe 'GET /search', search: true do
    it 'returns no results without a query' do
      create_current_term
      get '/search'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('No results found')
    end

    it 'returns results when given a query' do
      create_current_term
      com_sci = create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      comm = create(:subject_area, name: 'Communication', code: 'COMM')
      create(:course, :reindex, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: 69)
      create(:course, :reindex, subject_area: com_sci, title: 'Graduate Beep Boop', number: 420)
      create(:course, :reindex, subject_area: comm, title: 'Intro to Comm', number: 10)

      get '/search?q=com+sci'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'COM SCI 69'
      expect(response.body).to include 'Introduction to the Beep Boop'
      expect(response.body).not_to include 'COMM 10'
      expect(response.body).not_to include 'Intro to Comm'
      expect(response.body).to include 'Displaying <b>all 2</b> results'
    end
  end

  describe 'GET /suggestions', search: true do
    it 'raise error without query' do
      expect { get '/search/suggestions' }.to raise_error(ActionController::BadRequest)
    end

    it 'returns no suggestions with q=' do
      get '/search/suggestions?q='
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to be_empty
    end

    it 'returns suggestions with q=com+sci' do
      create_current_term
      subject_area = create :subject_area, code: 'COM SCI', id: 420
      create :course, :reindex,
             subject_area: subject_area,
             id: 69,
             number: '30',
             title: 'Introduction to Computer Science 0'
      create_list :course, 10, :reindex, subject_area: subject_area

      get '/search/suggestions?q=com+sci'
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to be 8
      expect(parsed_body.first).to match({
                                           'id' => a_string_starting_with('Course'),
                                           'searchableType' => 'Course',
                                           'searchable' => {
                                             'id' => be_a(Integer),
                                             'title' => a_string_starting_with('Introduction to Computer Science'),
                                             'number' => be_a(String),
                                             'subjectAreaCode' => 'COM SCI',
                                             'linkUrl' => a_string_starting_with('/courses/'),
                                           },
                                         })
    end

    it 'returns no suggestions with q=adsfasdfasfd' do
      subject_area = create :subject_area, code: 'COM SCI'
      create_list :course, 10, :reindex, subject_area: subject_area
      get '/search/suggestions?q=adsfasdfasfd'
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to be_empty
    end
  end
end
