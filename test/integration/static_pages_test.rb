# typed: strict
# frozen_string_literal: true

require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  describe 'GET /faq' do
    it 'shows a header' do
      create_current_term
      get '/faq'
      assert_response :ok
      assert_select 'h2', 'Frequently Asked Questions'
    end
  end

  describe 'GET /privacy' do
    it 'shows a header' do
      get '/privacy'
      assert_response :ok
      assert_select 'h1', 'Privacy Policy'
    end
  end

  describe 'GET /terms' do
    it 'shows a header' do
      get '/terms'
      assert_response :ok
      assert_select 'h1', 'Terms of Use'
    end
  end
end
