# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
course = T.cast(course, Course)

json.terms(course.terms.sort.reverse.map { |t| { term: t.term, readable: t.readable } })
json.preceding_course do
  preceding_course = T.let(course.preceding_course_with_subject, T.nilable(Course))
  if preceding_course.nil?
    json.nil!
  else
    json.id preceding_course.id
    json.title preceding_course.title
    json.number preceding_course.number
    json.subject_area_code preceding_course.subject_area_code
  end
end
json.superseding_course do
  superseding_course = T.let(course.superseding_course_with_subject, T.nilable(Course))
  if superseding_course.nil?
    json.nil!
  else
    json.id superseding_course.id
    json.title superseding_course.title
    json.number superseding_course.number
    json.subject_area_code superseding_course.subject_area_code
  end
end
