# typed: strict
# frozen_string_literal: true

require 'test_helper'

class SubjectAreaTest < ActiveSupport::TestCase
  describe '#most_popular' do
    it 'returns Computer Science as a popular course' do
      prev_term = create(:term, term: '80F')
      term = create(:term, term: '81W')
      current_psychology = create(:subject_area, name: 'Psychology', code: 'PSYCH')
      prev_psychology = create(:subject_area, name: 'Psychology', code: 'PSCH', superseding_subject_area: current_psychology)

      prev_psych_course = create(:course, subject_area: prev_psychology)
      current_psych_course = create(:course, subject_area: current_psychology)

      instructor = create(:instructor, first_names: ['Paul'], last_names: ['Eggert'])
      create_list(:section, 2, course: prev_psych_course, term: prev_term, instructor:)
      create_list(:section, 2, course: current_psych_course, term:, instructor:)

      popular_courses = SubjectArea.most_popular
      assert_includes(popular_courses, current_psychology)
      assert_not_includes(popular_courses, prev_psychology)
    end
  end
end
