# typed: strict
# frozen_string_literal: true

@sections = T.let(@sections, Section::ActiveRecord_Relation)
json = T.unsafe(json)

json.partial!('sections/section', collection: @sections, as: :section)
