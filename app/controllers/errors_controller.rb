# typed: strict
# frozen_string_literal: true

class ErrorsController < ApplicationController
  extend T::Sig

  sig { void }
  def not_found
    render(status: :not_found)
  end

  sig { void }
  def unprocessable_entity
    render(status: :unprocessable_entity)
  end

  sig { void }
  def internal_server_error
    render(status: :internal_server_error)
  end
end
