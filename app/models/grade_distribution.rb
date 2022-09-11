# typed: strict
# frozen_string_literal: true

class GradeDistribution < ApplicationRecord
  extend T::Sig

  belongs_to :section

  sig { returns(T::Array[Float]) }
  def to_a
    [
      percent_a_plus,
      percent_a,
      percent_a_minus,
      percent_b_plus,
      percent_b,
      percent_b_minus,
      percent_c_plus,
      percent_c,
      percent_c_minus,
      percent_d_plus,
      percent_d,
      percent_d_minus,
      percent_f,
    ]
  end
end
