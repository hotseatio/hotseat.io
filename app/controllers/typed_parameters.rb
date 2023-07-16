# typed: ignore # rubocop:disable Sorbet/FalseSigil, Sorbet/ValidSigil
# frozen_string_literal: true

# This file has been copied from sorbet-rails:
# https://github.com/chanzuckerberg/sorbet-rails/blob/master/lib/sorbet-rails/typed_params.rb#L5

require "sorbet-coerce"

module TypedParams
  # A sorbet-coerce wrapper for coercing typed controller parameters
  define_singleton_method(:[]) do |type|
    Class.new do
      define_method(:extract!) do |params, raise_coercion_error: nil|
        TypeCoerce[type].new.from(
          params.permit!.to_h,
          raise_coercion_error:,
        )
      rescue TypeCoerce::CoercionError, TypeCoerce::ShapeError, TypeError, ArgumentError => e
        raise ActionController::BadRequest, e
      end
    end
  end
end
