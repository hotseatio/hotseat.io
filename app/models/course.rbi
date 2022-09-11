# typed: strong
# frozen_string_literal: true

class Course
  sig { params(term: String, params: T::Hash[Symbol, T.untyped]).returns(T.untyped) }
  def self.search(term, params); end
end
