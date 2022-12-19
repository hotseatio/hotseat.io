# typed: strict
# frozen_string_literal: true

section = T.cast(section, Section)
json = T.unsafe(json)

json.(section,
      :id,
      :days,
      :times,
      :locations,
      :registrar_instructors,
      :course_id,
      :index)
json.term do
  json.partial!('terms/term', term: section.term)
end

json.instructor do
  json.partial!('instructors/instructor', instructor: section.instructor)
end
