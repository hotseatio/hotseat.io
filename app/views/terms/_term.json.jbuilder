# typed: strict
# frozen_string_literal: true

term = T.cast(term, Term)
json = T.unsafe(json)

json.term term.term
json.readable term.readable
