# typed: strict
# frozen_string_literal: true

# Not needed to run, but allows Sorbet to find the url_for function
extend ActionView::RoutingUrlFor # rubocop:disable Style/MixinUsage

course = T.cast(course, Course)
json = T.unsafe(json)

json.id(course.id)
json.title(course.title)
json.number(course.number)
json.subject_area(course.subject_area, partial: "subject_areas/subject_area", as: :subject_area)
json.terms(course.terms.sort.reverse, partial: "terms/term", as: :term)
json.link_url(url_for(course))
