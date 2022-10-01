# typed: strict
# frozen_string_literal: true

# Not needed to run, but allows Sorbet to find the url_for function
extend ActionView::RoutingUrlFor # rubocop:disable Style/MixinUsage

instructor = T.let(instructor, T.nilable(Instructor))
json = T.unsafe(json)

unless instructor.nil?
  json.id instructor.id
  json.full_label instructor.full_label
  json.link_url url_for(instructor)
end
