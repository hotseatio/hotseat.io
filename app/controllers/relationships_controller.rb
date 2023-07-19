# typed: strict
# frozen_string_literal: true

class RelationshipsController < ApplicationController
  extend T::Sig

  before_action :authenticate_or_redirect_user

  class CreateParams < T::Struct
    const :section_id, Integer
    const :subscribe, T::Boolean
  end

  sig { void }
  def create
    typed_params = TypedParams.extract!(CreateParams, params)
    section = Section.find(typed_params.section_id)
    user = T.must(current_user)

    if typed_params.subscribe
      user.subscribe_to_section(section)
      render(json: { msg: "Subscribed" })
    else
      user.follow(section)
      render(json: { msg: "Followed" })
    end
  end

  class DestroyParams < T::Struct
    const :section_id, Integer
    const :subscription_only, T::Boolean
  end

  sig { void }
  def destroy
    typed_params = TypedParams.extract!(DestroyParams, params)
    user = T.must(current_user)

    relationship = user.relationships.find_by!(section_id: typed_params.section_id)
    section = T.must(relationship.section)
    if typed_params.subscription_only
      user.unsubscribe_to_section(section)
      render(json: { msg: "Unsubscribed" })
    else
      begin
        user.unfollow(section)
        render(json: { msg: "Unfollowed" })
      rescue ActiveRecord::RecordNotDestroyed
        render(json: { msg: "You cannot unfollow a class you've reviewed! Did you mean to unsubscribe?" }, status: :bad_request)
      end
    end
  end

  class UnsubscribeParams < T::Struct
    const :id, Integer
  end

  sig { void }
  def unsubscribe
    typed_params = TypedParams.extract!(UnsubscribeParams, params)
    user = T.must(current_user)
    section = Section.find(typed_params.id)
    course = section.course

    successfully_unsubscribed = user.unsubscribe_to_section(section)
    if successfully_unsubscribed
      flash[:success] = "Unsubscribed to alerts for #{course.short_title}"
    else
      flash[:error] = "You aren't subscribed to notifications for #{course.short_title}!"
    end
    redirect_to(my_courses_url)
  end

  private

  # Devise has a method that does this, authenticate_user!, but it returns 401
  # instead of a redirect on AJAX requests.
  sig { void }
  def authenticate_or_redirect_user
    return if user_signed_in?

    flash[:error] = "You must be logged in to follow a class!"
    redirect_to(new_user_session_path, turbolinks: false)
  end
end
