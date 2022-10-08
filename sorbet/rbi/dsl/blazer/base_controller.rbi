# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Blazer::BaseController`.
# Please instead update this file by running `bin/tapioca dsl Blazer::BaseController`.

class Blazer::BaseController
  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Blazer::BaseHelper

    sig { returns(T.untyped) }
    def ahoy; end

    sig { returns(T.untyped) }
    def alert; end

    sig { returns(T.untyped) }
    def blazer_user; end

    sig { params(key: T.untyped).returns(T.untyped) }
    def combined_fragment_cache_key(key); end

    sig { returns(T.untyped) }
    def content_security_policy?; end

    sig { returns(T.untyped) }
    def content_security_policy_nonce; end

    sig { returns(T.untyped) }
    def cookies; end

    sig { returns(T.untyped) }
    def current_user; end

    sig { returns(T.untyped) }
    def current_visit; end

    sig { returns(T.untyped) }
    def devise_controller?; end

    sig { params(form_options: T.untyped).returns(T.untyped) }
    def form_authenticity_token(form_options: T.unsafe(nil)); end

    sig { returns(T.untyped) }
    def notice; end

    sig { returns(T.untyped) }
    def protect_against_forgery?; end

    sig { params(scope: T.untyped).returns(T.untyped) }
    def signed_in?(scope = T.unsafe(nil)); end

    sig { returns(T.untyped) }
    def user_session; end

    sig { returns(T.untyped) }
    def user_signed_in?; end

    sig { params(resource: T.untyped, var_params: T.untyped).returns(T.untyped) }
    def variable_params(resource, var_params = T.unsafe(nil)); end

    sig { returns(T.untyped) }
    def view_cache_dependencies; end

    sig { returns(T.untyped) }
    def warden; end
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end