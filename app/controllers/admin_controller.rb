# typed: strict
# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authorize_user!

  private

  sig { returns(T.untyped) }
  def authorize_user!
    unless current_user&.admin?
      flash[:error] = 'You are not authorized to view that page.'
      redirect_to(root_path)
    end
  end
end
