# typed: false

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `mailkick` gem.
# Please instead update this file by running `bin/tapioca gem mailkick`.

# https://github.com/sendgrid/sendgrid-ruby
#
# source://mailkick//lib/mailkick/legacy.rb#1
module Mailkick
  # source://mailkick//lib/mailkick.rb#29
  def message_verifier=(val); end

  # source://mailkick//lib/mailkick.rb#27
  def mount; end

  # source://mailkick//lib/mailkick.rb#27
  def mount=(val); end

  # source://mailkick//lib/mailkick.rb#27
  def process_opt_outs_method; end

  # source://mailkick//lib/mailkick.rb#27
  def process_opt_outs_method=(val); end

  # source://mailkick//lib/mailkick.rb#28
  def secret_token; end

  # source://mailkick//lib/mailkick.rb#27
  def services; end

  # source://mailkick//lib/mailkick.rb#27
  def services=(val); end

  class << self
    # source://mailkick//lib/mailkick.rb#38
    def discover_services; end

    # source://mailkick//lib/mailkick.rb#34
    def fetch_opt_outs; end

    # @raise [ArgumentError]
    #
    # source://mailkick//lib/mailkick.rb#53
    def generate_token(subscriber, list); end

    # source://mailkick//lib/mailkick.rb#49
    def message_verifier; end

    # source://mailkick//lib/mailkick.rb#29
    def message_verifier=(val); end

    # source://mailkick//lib/mailkick.rb#27
    def mount; end

    # source://mailkick//lib/mailkick.rb#27
    def mount=(val); end

    # source://mailkick//lib/mailkick.rb#27
    def process_opt_outs_method; end

    # source://mailkick//lib/mailkick.rb#27
    def process_opt_outs_method=(val); end

    # source://railties/7.0.6/lib/rails/engine.rb#405
    def railtie_helpers_paths; end

    # source://railties/7.0.6/lib/rails/engine.rb#394
    def railtie_namespace; end

    # source://railties/7.0.6/lib/rails/engine.rb#409
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end

    # source://mailkick//lib/mailkick.rb#28
    def secret_token; end

    # source://mailkick//lib/mailkick.rb#44
    def secret_token=(token); end

    # source://mailkick//lib/mailkick.rb#27
    def services; end

    # source://mailkick//lib/mailkick.rb#27
    def services=(val); end

    # source://railties/7.0.6/lib/rails/engine.rb#397
    def table_name_prefix; end

    # source://railties/7.0.6/lib/rails/engine.rb#401
    def use_relative_model_naming?; end
  end
end

# source://mailkick//lib/mailkick/engine.rb#2
class Mailkick::Engine < ::Rails::Engine
  class << self
    # source://activesupport/7.0.6/lib/active_support/callbacks.rb#68
    def __callbacks; end
  end
end

# source://mailkick//lib/mailkick/legacy.rb#2
module Mailkick::Legacy
  class << self
    # source://mailkick//lib/mailkick/legacy.rb#30
    def opt_in(options); end

    # source://mailkick//lib/mailkick/legacy.rb#15
    def opt_out(options); end

    # source://mailkick//lib/mailkick/legacy.rb#38
    def opt_outs(options = T.unsafe(nil)); end

    # checks for table as long as it exists
    #
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/legacy.rb#4
    def opt_outs?; end

    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/legacy.rb#11
    def opted_out?(options); end

    # source://mailkick//lib/mailkick/legacy.rb#62
    def opted_out_emails(options = T.unsafe(nil)); end

    # source://mailkick//lib/mailkick/legacy.rb#66
    def opted_out_users(options = T.unsafe(nil)); end
  end
end

# source://mailkick//lib/mailkick/model.rb#2
module Mailkick::Model
  # source://mailkick//lib/mailkick/model.rb#3
  def has_subscriptions; end
end

class Mailkick::OptOut < ::ActiveRecord::Base
  include ::Mailkick::OptOut::GeneratedAttributeMethods
  include ::Mailkick::OptOut::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  # source://activerecord/7.0.6/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_user(*args); end

  class << self
    # source://activesupport/7.0.6/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://activerecord/7.0.6/lib/active_record/reflection.rb#11
    def _reflections; end

    # source://activemodel/7.0.6/lib/active_model/validations.rb#52
    def _validators; end

    # source://activerecord/7.0.6/lib/active_record/enum.rb#116
    def defined_enums; end

    # source://kaminari-activerecord/1.2.2/lib/kaminari/activerecord/active_record_model_extension.rb#15
    def page(num = T.unsafe(nil)); end
  end
end

module Mailkick::OptOut::GeneratedAssociationMethods
  # source://activerecord/7.0.6/lib/active_record/associations/builder/singular_association.rb#19
  def reload_user; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/association.rb#103
  def user; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/association.rb#111
  def user=(value); end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/belongs_to.rb#132
  def user_changed?; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/belongs_to.rb#136
  def user_previously_changed?; end
end

module Mailkick::OptOut::GeneratedAttributeMethods; end

# source://mailkick//lib/mailkick/serializer.rb#4
class Mailkick::Serializer
  class << self
    # source://mailkick//lib/mailkick/serializer.rb#5
    def dump(value); end

    # source://mailkick//lib/mailkick/serializer.rb#9
    def load(value); end
  end
end

# source://mailkick//lib/mailkick/service.rb#2
class Mailkick::Service
  # source://mailkick//lib/mailkick/service.rb#3
  def fetch_opt_outs; end
end

# source://mailkick//lib/mailkick/service/aws_ses.rb#5
class Mailkick::Service::AwsSes < ::Mailkick::Service
  # @return [AwsSes] a new instance of AwsSes
  #
  # source://mailkick//lib/mailkick/service/aws_ses.rb#11
  def initialize(options = T.unsafe(nil)); end

  # source://mailkick//lib/mailkick/service/aws_ses.rb#15
  def opt_outs; end

  private

  # source://mailkick//lib/mailkick/service/aws_ses.rb#42
  def client; end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/aws_ses.rb#36
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/aws_ses.rb#6
Mailkick::Service::AwsSes::REASONS_MAP = T.let(T.unsafe(nil), Hash)

# source://mailkick//lib/mailkick/service/mailchimp.rb#5
class Mailkick::Service::Mailchimp < ::Mailkick::Service
  # @return [Mailchimp] a new instance of Mailchimp
  #
  # source://mailkick//lib/mailkick/service/mailchimp.rb#6
  def initialize(options = T.unsafe(nil)); end

  # TODO paginate
  #
  # source://mailkick//lib/mailkick/service/mailchimp.rb#12
  def opt_outs; end

  # source://mailkick//lib/mailkick/service/mailchimp.rb#20
  def spam_reports; end

  # source://mailkick//lib/mailkick/service/mailchimp.rb#16
  def unsubscribes; end

  protected

  # source://mailkick//lib/mailkick/service/mailchimp.rb#30
  def fetch(response, reason); end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/mailchimp.rb#24
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/mailgun.rb#5
class Mailkick::Service::Mailgun < ::Mailkick::Service
  # @return [Mailgun] a new instance of Mailgun
  #
  # source://mailkick//lib/mailkick/service/mailgun.rb#6
  def initialize(options = T.unsafe(nil)); end

  # source://mailkick//lib/mailkick/service/mailgun.rb#25
  def bounces; end

  # source://mailkick//lib/mailkick/service/mailgun.rb#13
  def opt_outs; end

  # source://mailkick//lib/mailkick/service/mailgun.rb#21
  def spam_reports; end

  # source://mailkick//lib/mailkick/service/mailgun.rb#17
  def unsubscribes; end

  protected

  # source://mailkick//lib/mailkick/service/mailgun.rb#35
  def fetch(response, reason); end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/mailgun.rb#29
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/mandrill.rb#5
class Mailkick::Service::Mandrill < ::Mailkick::Service
  # TODO remove ENV["MANDRILL_APIKEY"]
  #
  # @return [Mandrill] a new instance of Mandrill
  #
  # source://mailkick//lib/mailkick/service/mandrill.rb#14
  def initialize(options = T.unsafe(nil)); end

  # TODO paginate
  #
  # source://mailkick//lib/mailkick/service/mandrill.rb#22
  def opt_outs; end

  class << self
    # TODO remove ENV["MANDRILL_APIKEY"]
    #
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/mandrill.rb#33
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/mandrill.rb#6
Mailkick::Service::Mandrill::REASONS_MAP = T.let(T.unsafe(nil), Hash)

# source://mailkick//lib/mailkick/service/postmark.rb#5
class Mailkick::Service::Postmark < ::Mailkick::Service
  # @return [Postmark] a new instance of Postmark
  #
  # source://mailkick//lib/mailkick/service/postmark.rb#12
  def initialize(options = T.unsafe(nil)); end

  # source://mailkick//lib/mailkick/service/postmark.rb#20
  def bounces; end

  # source://mailkick//lib/mailkick/service/postmark.rb#16
  def opt_outs; end

  protected

  # source://mailkick//lib/mailkick/service/postmark.rb#30
  def fetch(response); end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/postmark.rb#24
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/postmark.rb#6
Mailkick::Service::Postmark::REASONS_MAP = T.let(T.unsafe(nil), Hash)

# source://mailkick//lib/mailkick/service/sendgrid.rb#5
class Mailkick::Service::SendGrid < ::Mailkick::Service
  # @return [SendGrid] a new instance of SendGrid
  #
  # source://mailkick//lib/mailkick/service/sendgrid.rb#6
  def initialize(options = T.unsafe(nil)); end

  # source://mailkick//lib/mailkick/service/sendgrid.rb#24
  def bounces; end

  # TODO paginate
  #
  # source://mailkick//lib/mailkick/service/sendgrid.rb#12
  def opt_outs; end

  # source://mailkick//lib/mailkick/service/sendgrid.rb#20
  def spam_reports; end

  # source://mailkick//lib/mailkick/service/sendgrid.rb#16
  def unsubscribes; end

  protected

  # source://mailkick//lib/mailkick/service/sendgrid.rb#34
  def fetch(klass, reason); end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/sendgrid.rb#28
    def discoverable?; end
  end
end

# source://mailkick//lib/mailkick/service/sendgrid_v2.rb#5
class Mailkick::Service::SendGridV2 < ::Mailkick::Service
  # @return [SendGridV2] a new instance of SendGridV2
  #
  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#6
  def initialize(options = T.unsafe(nil)); end

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#22
  def bounces; end

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#10
  def opt_outs; end

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#18
  def spam_reports; end

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#14
  def unsubscribes; end

  protected

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#32
  def client; end

  # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#36
  def fetch(query, reason); end

  class << self
    # @return [Boolean]
    #
    # source://mailkick//lib/mailkick/service/sendgrid_v2.rb#26
    def discoverable?; end
  end
end

# backwards compatibility
#
# source://mailkick//lib/mailkick/service/sendgrid.rb#46
Mailkick::Service::Sendgrid = Mailkick::Service::SendGrid

class Mailkick::Subscription < ::ActiveRecord::Base
  include ::Mailkick::Subscription::GeneratedAttributeMethods
  include ::Mailkick::Subscription::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  # source://activerecord/7.0.6/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_subscriber(*args); end

  class << self
    # source://activesupport/7.0.6/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://activerecord/7.0.6/lib/active_record/reflection.rb#11
    def _reflections; end

    # source://activemodel/7.0.6/lib/active_model/validations.rb#52
    def _validators; end

    # source://activerecord/7.0.6/lib/active_record/enum.rb#116
    def defined_enums; end

    # source://kaminari-activerecord/1.2.2/lib/kaminari/activerecord/active_record_model_extension.rb#15
    def page(num = T.unsafe(nil)); end
  end
end

module Mailkick::Subscription::GeneratedAssociationMethods
  # source://activerecord/7.0.6/lib/active_record/associations/builder/singular_association.rb#19
  def reload_subscriber; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/association.rb#103
  def subscriber; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/association.rb#111
  def subscriber=(value); end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/belongs_to.rb#132
  def subscriber_changed?; end

  # source://activerecord/7.0.6/lib/active_record/associations/builder/belongs_to.rb#136
  def subscriber_previously_changed?; end
end

module Mailkick::Subscription::GeneratedAttributeMethods; end

class Mailkick::SubscriptionsController < ::ActionController::Base
  def show; end
  def subscribe; end
  def unsubscribe; end

  protected

  def legacy_options; end
  def opted_out?; end
  def set_subscription; end
  def subscribe_url; end
  def subscribed?; end
  def subscription; end
  def unsubscribe_url; end

  private

  # source://actionview/7.0.6/lib/action_view/layouts.rb#328
  def _layout(lookup_context, formats); end

  def _layout_from_proc; end

  class << self
    # source://activesupport/7.0.6/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://actionpack/7.0.6/lib/abstract_controller/helpers.rb#11
    def _helper_methods; end

    # source://actionpack/7.0.6/lib/action_controller/metal.rb#210
    def middleware_stack; end
  end
end

module Mailkick::SubscriptionsController::HelperMethods
  include ::ActionText::ContentHelper
  include ::ActionText::TagHelper
  include ::Turbo::DriveHelper
  include ::Turbo::FramesHelper
  include ::Turbo::IncludesHelper
  include ::Turbo::StreamsHelper
  include ::ActionView::Helpers::CaptureHelper
  include ::ActionView::Helpers::OutputSafetyHelper
  include ::ActionView::Helpers::TagHelper
  include ::Turbo::Streams::ActionHelper
  include ::ActionController::Base::HelperMethods

  def opted_out?(*args, **_arg1, &block); end
  def subscribe_url(*args, **_arg1, &block); end
  def subscribed?(*args, **_arg1, &block); end
  def unsubscribe_url(*args, **_arg1, &block); end
end

# source://mailkick//lib/mailkick/url_helper.rb#2
module Mailkick::UrlHelper
  # source://mailkick//lib/mailkick/url_helper.rb#3
  def mailkick_unsubscribe_url(subscriber, list, **options); end
end

# source://mailkick//lib/mailkick/version.rb#2
Mailkick::VERSION = T.let(T.unsafe(nil), String)
