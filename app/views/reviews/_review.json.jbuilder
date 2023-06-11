# typed: strict
# frozen_string_literal: true

review = T.cast(review, Review)
json = T.unsafe(json)

json.id(review.id)
json.section_id(T.must(review.section).id.to_s)
json.organization(review.organization.to_s)
json.clarity(review.clarity.to_s)
json.overall(review.overall.to_s)
json.weekly_time(review.read_attribute_before_type_cast(:weekly_time))
json.grade(review.read_attribute_before_type_cast(:grade))
json.group_project(review.has_group_project.to_s)
json.extra_credit(review.offers_extra_credit.to_s)
json.attendance(review.requires_attendance.to_s)
json.midterm_count(review.midterm_count.to_s)
json.final(review.read_attribute_before_type_cast(:final))
json.textbook(review.recommend_textbook.to_s)
json.comments(review.comments)
