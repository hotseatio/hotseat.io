# typed: strict
# frozen_string_literal: true

review = T.cast(review, Review)
json = T.unsafe(json)

json.id(review.id)
json.organization(review.organization)
json.clarity(review.clarity)
json.overall(review.overall)
json.weekly_time(review.read_attribute_before_type_cast(:weekly_time))
json.grade(review.read_attribute_before_type_cast(:grade))
json.group_project(review.has_group_project.to_s)
json.extra_credit(review.offers_extra_credit.to_s)
json.attendance(review.requires_attendance.to_s)
json.midterm_count(review.midterm_count)
json.final(review.read_attribute_before_type_cast(:final))
json.textbook(review.reccomend_textbook.to_s)
json.comments(review.comments)
