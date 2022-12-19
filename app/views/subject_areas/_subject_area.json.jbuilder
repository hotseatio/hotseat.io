# typed: strict
# frozen_string_literal: true

# Not needed to run, but allows Sorbet to find the url_for function
extend ActionView::RoutingUrlFor # rubocop:disable Style/MixinUsage

subject_area = T.cast(subject_area, SubjectArea)
json = T.unsafe(json)

json.id(subject_area.id)
json.name(subject_area.name)
json.code(subject_area.code)
json.link_url(url_for(subject_area))
