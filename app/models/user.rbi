# typed: strong
# frozen_string_literal: true

class User
  sig { params(list: String).void }
  def subscribe(list); end
end
