# typed: strict
# frozen_string_literal: true

class SectionsController < ApplicationController
  extend T::Sig

  class EnrollParams < T::Struct
    const :id, Integer
  end

  # GET /enroll/:id
  sig { void }
  def enroll
    typed_params = TypedParams[EnrollParams].new.extract!(params)
    section = Section.find(typed_params.id)
    redirect_to(section.enroll_link, allow_other_host: true)
  end
end
