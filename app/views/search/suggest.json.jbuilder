# typed: strict
# frozen_string_literal: true

@results = T.let(@results, T.untyped)
json = T.unsafe(json)

json.array! @results do |result|
  searchable_type = T.let(result.class.name, String)
  json.id "#{searchable_type}#{result.id}"
  json.searchable_type searchable_type
  json.searchable do
    case result.class.name
    when 'Course'
      course = T.let(result, Course)
      json.id course.id
      json.title course.title
      json.number course.number
      json.subject_area_code course.subject_area.code
      json.link_url url_for(course)
    when 'Instructor'
      instructor = T.let(result, Instructor)
      json.id instructor.id
      json.full_label instructor.full_label
      json.link_url url_for(instructor)
    end
  end
end
