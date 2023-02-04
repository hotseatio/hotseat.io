# typed: strict
# frozen_string_literal: true

require "twilio-ruby"

class UsersController < ApplicationController
  extend T::Sig

  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  sig { void }
  def initialize
    super
    @term = T.let(nil, T.nilable(Term))
    @current_sections = T.let(nil, T.nilable(Section::RelationType))
    @previous_sections = T.let(nil, T.nilable(Section::RelationType))
    @subject_areas = T.let(nil, T.nilable(SubjectArea::ActiveRecord_Relation))
  end

  # GET /my-courses
  sig { void }
  def my_courses
    user = T.must(current_user)
    if params[:payment_success]
      flash[:success] = "Thank you for your purchase! You now have #{view_context.pluralize(user.notification_token_count, 'tokens')}."
    elsif session[:referred_review_created] && T.must(current_user).referred_by
      referring_user = T.must(T.must(current_user).referred_by)
      flash[:info] = "Review submitted! Since you were referred by #{referring_user.name}, you'll receive 2 notification tokens once your review is approved. (We'll text you when that happens!)"
      session.delete(:referred_review_created)
    elsif session[:review_submitted]
      flash[:info] = "Review submitted! Once approved, you'll received a notification token. (We'll text you when that happens!)"
      session.delete(:review_submitted)
    end
    @term = Term.current
    user = T.must(current_user)
    sections = user.sections.joins(:course).includes(:instructor, course: [:subject_area])
    @current_sections = sections.where(term: Term.current_and_upcoming).order_by_course.order_by_index
    @previous_sections = sections.joins(:term).where.not(term: @term).merge(Term.order_chronologically_desc).order_by_course.order_by_index
    @subject_areas = SubjectArea.most_popular.shuffle
  end

  sig { void }
  def details
    @user = T.let(current_user, T.nilable(User))
    @user = T.must(@user)
  end

  # GET /settings
  sig { void }
  def edit; end

  class UpdateParams < T::Struct
    const :id, Integer
    const :beta_tester, T.nilable(T::Boolean)
  end

  # PUT /users/:id
  sig { void }
  def update
    typed_params = TypedParams[UpdateParams].new.extract!(params)
    new_beta_status = typed_params.beta_tester
    user = T.must(current_user)
    user.beta_tester = new_beta_status unless new_beta_status.nil?
    user.save!

    render(json: { title: "Settings updated!" }, status: :ok)
  rescue ActiveRecord::RecordInvalid => e
    logger.error(e.inspect)
    render(json: { title: "Could not update settings", msg: "Please make sure everything is properly formatted and try again." }, status: :bad_request)
  end

  class VerifyPhoneParams < T::Struct
    const :phone, String
  end

  sig { void }
  def verify_phone
    typed_params = TypedParams[VerifyPhoneParams].new.extract!(params)
    normalized_phone = User.normalize_phone(typed_params.phone)
    formatted_phone = User.format_phone(normalized_phone)

    # if T.unsafe(Rails.env).production?
    user = T.must(current_user)
    user.set_new_otp_secret
    user.save!

    client = Aws::SNS::Client.new
    client.publish({
                     phone_number: formatted_phone,
                     message: "Your Hotseat code: #{user.generate_otp_code}",
                   })

    # account_sid = ENV.fetch("TWILIO_ACCOUNT_SID", nil)
    # verify_sid = ENV.fetch("TWILIO_VERIFY_SID", nil)
    # auth_token = ENV.fetch("TWILIO_AUTH_TOKEN", nil)
    # client = Twilio::REST::Client.new(account_sid, auth_token)
    # verification = client.verify
    #                      .services(verify_sid)
    #                      .verifications
    #                      .create(to: normalized_phone, channel: "sms")

    # logger.info(verification)
    render(json: {
             msg: "Verification code sent",
             formattedPhone: formatted_phone,
           }, status: :ok)
    # else
    #   render(json: {
    #            msg: "In development mode; no verification code sent",
    #            confirmationCodePlaceholder: "Dev mode; put any 6-digit number",
    #            formattedPhone: formatted_phone,
    #          }, status: :ok)
    # end
    # rescue Twilio::REST::RestError => e
    #   render(json: { msg: e.error_message }, status: e.status_code)
  end

  class ConfirmVerifyPhoneParams < T::Struct
    const :phone, String
    const :code, String
  end

  sig { void }
  def confirm_verify_phone
    typed_params = TypedParams[ConfirmVerifyPhoneParams].new.extract!(params)
    normalized_phone = User.normalize_phone(typed_params.phone)
    logger.info(normalized_phone)
    user = T.must(current_user)

    # success = if T.unsafe(Rails.env).development? || T.unsafe(Rails.env).test?
    #             true
    #           else
    #             user.validate_otp_code(typed_params.code)
    #           end
    success = user.validate_otp_code(typed_params.code)

    if success
      user.phone = normalized_phone
      user.delete_otp_secret
      user.save!
      render(json: { msg: "Code verified and phone saved" }, status: :ok)
    else
      render(json: { msg: "Invalid code" }, status: :bad_request)
    end
  rescue Twilio::REST::RestError => e
    render(json: { msg: e.error_message }, status: e.status_code)
  end

  sig { void }
  def remove_phone
    user = T.must(current_user)
    user.phone = nil
    user.relationships.update_all(notify: false)
    user.save!
    render(json: { msg: "Removed phone" }, status: :ok)
  end
end
