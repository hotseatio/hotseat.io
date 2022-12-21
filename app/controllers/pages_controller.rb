# typed: strict
# frozen_string_literal: true

class PagesController < ApplicationController
  extend T::Sig
  include HighVoltage::StaticPage

  layout :layout_for_page

  private

  sig { returns(String) }
  def layout_for_page
    case params[:id]
    when "terms", "privacy"
      "prose"
    else
      "application"
    end
  end
end
