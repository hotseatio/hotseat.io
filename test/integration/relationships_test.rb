# typed: strict
# frozen_string_literal: true

require 'test_helper'

class RelatioshipTest < ActionDispatch::IntegrationTest
  describe 'GET /unsubscribe/:section_id' do
    it 'unsubscribes to course alerts' do
      term = T.let(create_current_term, Term)
      user = T.let(create(:user), User)
      course = T.let(create(:course), Course)
      section = T.let(create(:section, course:, term:), Section)
      create(:relationship, user:, section:, notify: true)
      sign_in user

      get "/unsubscribe/#{section.id}"

      assert_redirected_to '/my-courses'
      assert_equal "Unsubscribed to alerts for #{course.short_title}", flash[:success]
    end

    it 'gives an error message when unsubscribing from a non-followed course' do
      term = T.let(create_current_term, Term)

      course = T.let(create(:course), Course)
      section = T.let(create(:section, course:, term:), Section)
      sign_in create(:user)

      get "/unsubscribe/#{section.id}"

      assert_redirected_to '/my-courses'
      assert_equal "You aren't subscribed to notifications for #{course.short_title}!", flash[:error]
    end
  end
end
