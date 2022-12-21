# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
@course = T.must(@course)
json.partial!("reviews/term_suggestions", course: @course)
