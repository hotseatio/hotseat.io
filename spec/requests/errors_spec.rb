# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /404' do
    it 'returns a 404 error' do
      create_current_term
      get '/404'
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Page Not Found')
    end
  end

  describe 'GET /422' do
    it 'returns a 422 error' do
      create_current_term
      get '/422'
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Unprocessable Entity')
    end
  end

  describe 'GET /internal_server_error' do
    it 'returns a 500 error' do
      create_current_term
      get '/500'
      expect(response).to have_http_status(:internal_server_error)
      expect(response.body).to include('Internal Server Error')
    end
  end
end
