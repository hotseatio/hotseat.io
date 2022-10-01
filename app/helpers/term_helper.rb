# typed: strict
# frozen_string_literal: true

module TermHelper
  extend T::Sig

  sig { params(term: Term, current_term: Term, upcoming_terms: T::Array[Term]).returns(ColorHelper::Color) }
  def term_badge_color(term, current_term, upcoming_terms)
    if upcoming_terms.include?(term)
      ColorHelper::Color::Green
    elsif term == current_term
      if current_term.after_week_four?
        ColorHelper::Color::Yellow
      else
        ColorHelper::Color::Green
      end
    else
      ColorHelper::Color::Gray
    end
  end
end
