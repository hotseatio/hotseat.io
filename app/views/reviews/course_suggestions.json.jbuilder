# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)

json.array! @results do |result|
  course = T.let(result, Course)
  json.id course.id
  json.title course.title
  json.number course.number
  json.subject_area_code course.subject_area_code
end
