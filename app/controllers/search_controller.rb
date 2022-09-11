# typed: strict
# frozen_string_literal: true

class SearchController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super
    @query = T.let(nil, T.nilable(String))
    @results = T.let(nil, T.untyped)
    @term = T.let(nil, T.nilable(Term))
  end

  class SearchParams < T::Struct
    const :q, String
  end

  class IndexParams < T::Struct
    const :q, T.nilable(String)
    const :page, T.nilable(Integer)
  end

  sig { void }
  def index
    typed_params = TypedParams[IndexParams].new.extract!(params)
    @term = Term.current
    @query = typed_params.q
    @results = Searchkick.search(@query,
                                 track: true,
                                 models: [Course, Instructor],
                                 fields: %i[search_text],
                                 match: :word_middle,
                                 page: typed_params.page,
                                 per_page: Kaminari.config.default_per_page,
                                 misspellings: false)
  end

  sig { void }
  def suggest
    typed_params = TypedParams[SearchParams].new.extract!(params)
    @query = typed_params.q
    @results = Searchkick.search(@query,
                                 track: true,
                                 models: [Course, Instructor],
                                 fields: %i[search_text],
                                 match: :word_middle,
                                 limit: 8,
                                 misspellings: false)
    render(formats: :json)
  end
end
