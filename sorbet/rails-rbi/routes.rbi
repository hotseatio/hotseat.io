# typed: strong
# This is an autogenerated file for Rails routes.
# Please run bundle exec rake rails_rbi:routes to regenerate.
class ActionController::Base
  include GeneratedUrlHelpers
end

class ActionController::API
  include GeneratedUrlHelpers
end

module ActionView::Helpers
  include GeneratedUrlHelpers
end

class ActionMailer::Base
  include GeneratedUrlHelpers
end

class ActionDispatch::IntegrationTest
  include GeneratedUrlHelpers
end

class ActionDispatch::SystemTestCase
  include GeneratedUrlHelpers
end

module GeneratedUrlHelpers
  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_url(*args, **kwargs); end

  # Sigs for route /users/auth/google_oauth2(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_google_oauth2_omniauth_authorize_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_google_oauth2_omniauth_authorize_url(*args, **kwargs); end

  # Sigs for route /users/auth/google_oauth2/callback(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_google_oauth2_omniauth_callback_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_google_oauth2_omniauth_callback_url(*args, **kwargs); end

  # Sigs for route /sign_in(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_user_session_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_user_session_url(*args, **kwargs); end

  # Sigs for route /sign_out(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def destroy_user_session_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def destroy_user_session_url(*args, **kwargs); end

  # Sigs for route /hotcount
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def ahoy_engine_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def ahoy_engine_url(*args, **kwargs); end

  # Sigs for route /blazer
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def blazer_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def blazer_url(*args, **kwargs); end

  # Sigs for route /searchjoy
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searchjoy_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searchjoy_url(*args, **kwargs); end

  # Sigs for route /admin/reviews(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_reviews_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_reviews_url(*args, **kwargs); end

  # Sigs for route /admin/reviews/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_review_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_review_url(*args, **kwargs); end

  # Sigs for route /admin/reviews/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_review_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_review_url(*args, **kwargs); end

  # Sigs for route /admin/reviews/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_review_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_review_url(*args, **kwargs); end

  # Sigs for route /checkout(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def checkout_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def checkout_url(*args, **kwargs); end

  # Sigs for route /subject-areas(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def subject_areas_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def subject_areas_url(*args, **kwargs); end

  # Sigs for route /subject-areas/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def subject_area_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def subject_area_url(*args, **kwargs); end

  # Sigs for route /courses/:course_id/instructors/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def course_instructor_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def course_instructor_url(*args, **kwargs); end

  # Sigs for route /courses(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def courses_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def courses_url(*args, **kwargs); end

  # Sigs for route /courses/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def course_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def course_url(*args, **kwargs); end

  # Sigs for route /reviews(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_url(*args, **kwargs); end

  # Sigs for route /reviews/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_review_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_review_url(*args, **kwargs); end

  # Sigs for route /reviews/course-suggestions(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_course_suggestions_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_course_suggestions_url(*args, **kwargs); end

  # Sigs for route /reviews/term-suggestions(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_term_suggestions_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_term_suggestions_url(*args, **kwargs); end

  # Sigs for route /reviews/section-suggestions(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_section_suggestions_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reviews_section_suggestions_url(*args, **kwargs); end

  # Sigs for route /instructors(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def instructors_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def instructors_url(*args, **kwargs); end

  # Sigs for route /instructors/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def instructor_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def instructor_url(*args, **kwargs); end

  # Sigs for route /search(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_url(*args, **kwargs); end

  # Sigs for route /search/suggestions(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_suggestions_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_suggestions_url(*args, **kwargs); end

  # Sigs for route /enroll/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def enroll_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def enroll_url(*args, **kwargs); end

  # Sigs for route /my-courses(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def my_courses_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def my_courses_url(*args, **kwargs); end

  # Sigs for route /user/details(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_details_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_details_url(*args, **kwargs); end

  # Sigs for route /settings(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_url(*args, **kwargs); end

  # Sigs for route /users/verify-phone(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_verify_phone_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_verify_phone_url(*args, **kwargs); end

  # Sigs for route /users/confirm-verify-phone(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_confirm_verify_phone_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_confirm_verify_phone_url(*args, **kwargs); end

  # Sigs for route /users/remove-phone(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_remove_phone_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def users_remove_phone_url(*args, **kwargs); end

  # Sigs for route /users/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def user_url(*args, **kwargs); end

  # Sigs for route /relationships(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def relationships_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def relationships_url(*args, **kwargs); end

  # Sigs for route /relationships/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def relationship_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def relationship_url(*args, **kwargs); end

  # Sigs for route /*id
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def page_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def page_url(*args, **kwargs); end

  # Sigs for route /recede_historical_location(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_recede_historical_location_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_recede_historical_location_url(*args, **kwargs); end

  # Sigs for route /resume_historical_location(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_resume_historical_location_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_resume_historical_location_url(*args, **kwargs); end

  # Sigs for route /refresh_historical_location(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_refresh_historical_location_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def turbo_refresh_historical_location_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/postmark/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_postmark_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_postmark_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/relay/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_relay_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_relay_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/sendgrid/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_sendgrid_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_sendgrid_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/mandrill/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_health_check_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_health_check_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/mandrill/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mailgun_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mailgun_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_source_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_source_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/sources(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_sources_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_sources_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_reroute_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_reroute_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_incinerate_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_incinerate_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_proxy_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_proxy_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_proxy_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_proxy_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_token(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/direct_uploads(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_url(*args, **kwargs); end

  # Sigs for route /pay
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def pay_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def pay_url(*args, **kwargs); end
end

module GeneratedUrlHelpers
  # Sigs for route /visits(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def visits_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def visits_url(*args, **kwargs); end

  # Sigs for route /events(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def events_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def events_url(*args, **kwargs); end
end

module GeneratedUrlHelpers
  # Sigs for route /queries/run(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def run_queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def run_queries_url(*args, **kwargs); end

  # Sigs for route /queries/cancel(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def cancel_queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def cancel_queries_url(*args, **kwargs); end

  # Sigs for route /queries/:id/refresh(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def refresh_query_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def refresh_query_url(*args, **kwargs); end

  # Sigs for route /queries/tables(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def tables_queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def tables_queries_url(*args, **kwargs); end

  # Sigs for route /queries/schema(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def schema_queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def schema_queries_url(*args, **kwargs); end

  # Sigs for route /queries/docs(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def docs_queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def docs_queries_url(*args, **kwargs); end

  # Sigs for route /queries(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def queries_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def queries_url(*args, **kwargs); end

  # Sigs for route /queries/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_query_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_query_url(*args, **kwargs); end

  # Sigs for route /queries/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_query_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_query_url(*args, **kwargs); end

  # Sigs for route /queries/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def query_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def query_url(*args, **kwargs); end

  # Sigs for route /checks/:id/run(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def run_check_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def run_check_url(*args, **kwargs); end

  # Sigs for route /checks(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def checks_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def checks_url(*args, **kwargs); end

  # Sigs for route /checks/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_check_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_check_url(*args, **kwargs); end

  # Sigs for route /checks/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_check_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_check_url(*args, **kwargs); end

  # Sigs for route /checks/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def check_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def check_url(*args, **kwargs); end

  # Sigs for route /dashboards/:id/refresh(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def refresh_dashboard_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def refresh_dashboard_url(*args, **kwargs); end

  # Sigs for route /dashboards(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboards_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboards_url(*args, **kwargs); end

  # Sigs for route /dashboards/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_dashboard_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_dashboard_url(*args, **kwargs); end

  # Sigs for route /dashboards/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_dashboard_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_dashboard_url(*args, **kwargs); end

  # Sigs for route /dashboards/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboard_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def dashboard_url(*args, **kwargs); end

  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_url(*args, **kwargs); end
end

module GeneratedUrlHelpers
  # Sigs for route /searches/overview(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def overview_searches_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def overview_searches_url(*args, **kwargs); end

  # Sigs for route /searches(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searches_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searches_url(*args, **kwargs); end

  # Sigs for route /searches/recent(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searches_recent_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def searches_recent_url(*args, **kwargs); end

  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_url(*args, **kwargs); end
end

module GeneratedUrlHelpers
  # Sigs for route /payments/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def payment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def payment_url(*args, **kwargs); end

  # Sigs for route /webhooks/stripe(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_stripe_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_stripe_url(*args, **kwargs); end

  # Sigs for route /webhooks/braintree(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_braintree_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_braintree_url(*args, **kwargs); end

  # Sigs for route /webhooks/paddle(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_paddle_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def webhooks_paddle_url(*args, **kwargs); end
end
