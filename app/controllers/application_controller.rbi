# typed: strong
# frozen_string_literal: true

class ApplicationController
  sig { returns(T.nilable(User)) }
  def current_user; end

  sig { returns(T::Boolean) }
  def user_signed_in?; end
end
