# typed: strict
# frozen_string_literal: true

require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  it 'contains the site title and some popular course' do
    term = create_current_term
    com_sci = create :subject_area, name: 'Computer Science', code: 'COM SCI'
    create :subject_area, name: 'Economics', code: 'ECON'
    create :subject_area, name: 'Physics', code: 'PHYSICS'

    instructor = create(:instructor, last_names: ['Nachenberg'])
    course = create(:course, subject_area: com_sci, title: 'Introduction to the Beep Boop', number: '32')
    create(:section, course:, term:, instructor:)

    get '/'
    assert_response :ok
    assert_select 'h1', 'hotseat.io'
    assert_select 'a', 'Computer Science'
    assert_select 'a', 'Economics'
    assert_select 'a', 'Physics'
  end
end
