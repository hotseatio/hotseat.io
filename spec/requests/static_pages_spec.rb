# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static Pages', type: :request do
  describe 'GET /faq' do
    it 'shows a header' do
      create_current_term
      get '/faq'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Frequently Asked Questions')
    end
  end

  describe 'GET /privacy' do
    it 'shows a header' do
      get '/privacy'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Privacy Policy')
    end
  end

  describe 'GET /terms' do
    it 'shows a header' do
      get '/terms'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Terms of Use')
    end
  end
end
