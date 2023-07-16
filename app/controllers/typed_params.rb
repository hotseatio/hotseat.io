# typed: strict
# frozen_string_literal: true

# This file has been copied from sorbet-rails:
# https://github.com/chanzuckerberg/sorbet-rails/blob/master/lib/sorbet-rails/typed_params.rb#L5

require "sorbet-coerce"

module TypedParams
  extend T::Sig
  include Kernel

  sig do
    type_parameters(:U)
      .params(
        type: T::Class[T.type_parameter(:U)],
        params: ActionController::Parameters,
        raise_coercion_error: T.nilable(T::Boolean),
      )
      .returns(T.type_parameter(:U))
  end
  def self.extract!(type, params, raise_coercion_error: nil)
    TypeCoerce[type].new.from(
      params.permit!.to_h,
      raise_coercion_error:,
    )
  rescue TypeCoerce::CoercionError, TypeCoerce::ShapeError, TypeError, ArgumentError => e
    raise ActionController::BadRequest, e
  end
end
