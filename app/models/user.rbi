# typed: strong
# frozen_string_literal: true

class User
  extend Devise::Models

  sig { params(list: String).void }
  def subscribe(list); end

  sig { params(list: String).void }
  def unsubscribe(list); end

  sig { params(list: String).returns(T::Boolean) }
  def subscribed?(list); end
end
