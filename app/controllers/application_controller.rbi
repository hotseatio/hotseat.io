# typed: strong
# frozen_string_literal: true

class ApplicationController
  sig { returns(T.nilable(User)) }
  def current_user; end

  sig { returns(T::Boolean) }
  def user_signed_in?; end

  sig { params(resource_or_scope: T.untyped).void }
  def sign_in_and_redirect(resource_or_scope); end
end
