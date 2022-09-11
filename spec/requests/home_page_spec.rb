# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe 'Home Page', type: :request do
  it 'contains the site title and some popular course' do
    term = create_current_term
    com_sci = create :subject_area, name: 'Computer Science', code: 'COM SCI'
    create :subject_area, name: 'Economics', code: 'ECON'
    create :subject_area, name: 'Physics', code: 'PHYSICS'

    instructor = create(:instructor, last_names: ['Nachenberg'])
    course = create(:course, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: 69)
    create(:section, course:, term:, instructor:)

    stub_const('HomePageController::COURSE_INSTRUCTOR_PAIRS', [[course.subject_area_code, course.number, instructor.last_names.first]])
    get '/'
    expect(response).to have_http_status(:ok)
    expect(response.body).to include 'hotseat.io'
    expect(response.body).to include 'Computer Science'
    expect(response.body).to include 'Economics'
    expect(response.body).to include 'Physics'
  end
end
