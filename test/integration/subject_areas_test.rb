# typed: strict
# frozen_string_literal: true

require 'test_helper'

class SubjectAreasTest < ActionDispatch::IntegrationTest
  describe 'GET /subject-areas' do
    it 'lists all subject areas' do
      create_current_term
      create(:subject_area, name: 'Computer Science', code: 'COM SCI')
      create(:subject_area, name: 'Communication', code: 'COMM')

      get '/subject-areas'

      assert_response :ok
      assert_select 'h2', 'Subject Areas'
      assert_select 'p', 'Computer Science'
      assert_select 'p', 'Communication'
      assert_select '.pagination-info', 'Displaying all 2 subject areas'
    end
  end

  describe 'GET /subject-areas/:id' do
    it 'lists only the current courses of a subject area' do
      term = create_current_term
      subject_area = create(:subject_area, name: 'Computer Science', code: 'COM SCI', id: 42)
      create_list(:course, 51, subject_area:)
      current_course = create(:course, subject_area:)
      create(:section, course: current_course, term:)

      get '/subject-areas/42'

      assert_response :ok
      assert_select 'p', /^Introduction to Computer Science I+/
      assert_select '.pagination-info', 'Showing 1 course'
    end

    it 'lists all the courses of a subject area when given filter=all' do
      create_current_term
      subject_area = create(:subject_area, name: 'Computer Science', code: 'COM SCI', id: 42)
      create_list(:course, 51, subject_area:)

      get '/subject-areas/42?filter=all'

      assert_response :ok
      assert_select 'p', /^Introduction to Computer Science I+/
      assert_select '.pagination-info', 'Showing 1 to 50 of 51 courses'
    end
  end
end
