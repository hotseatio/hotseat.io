# typed: strict
# frozen_string_literal: true

module Mock
  extend T::Sig

  sig { params(object: T.anything, method: Symbol).returns(Mocha::Expectation) }
  def self.expects(object, method)
    T.unsafe(object).expects(method)
  end

  sig { params(object: T.anything, method: Symbol).returns(Mocha::Expectation) }
  def self.stubs(object, method)
    T.unsafe(object).stubs(method)
  end
end
