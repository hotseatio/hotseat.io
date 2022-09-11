# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectArea, type: :model do
  include FactoryBot::Syntax::Methods

  describe 'most popular' do
    it 'returns Computer Science as a popular course' do
      prev_term = create :term, term: '80F'
      term = create :term, term: '81W'
      current_psychology = create(:subject_area, name: 'Psychology', code: 'PSYCH')
      prev_psychology = create(:subject_area, name: 'Psychology', code: 'PSCH', superseding_subject_area: current_psychology)

      prev_psych_course = create(:course, subject_area: prev_psychology)
      current_psych_course = create(:course, subject_area: current_psychology)

      instructor = create :instructor, first_names: ['Paul'], last_names: ['Eggert']
      create_list(:section, 2, course: prev_psych_course, term: prev_term, instructor:)
      create_list(:section, 2, course: current_psych_course, term:, instructor:)

      popular_courses = described_class.most_popular
      expect(popular_courses).to include(current_psychology)
      expect(popular_courses).not_to include(prev_psychology)
    end
  end
end
