# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `sentry-rails` gem.
# Please instead update this file by running `bin/tapioca gem sentry-rails`.

# source://sentry-rails//lib/sentry/rails/version.rb#1
module Sentry
  class << self
    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#285
    def add_breadcrumb(breadcrumb, **options); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#488
    def add_global_event_processor(&block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#91
    def apply_patches(config); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#67
    def background_worker; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#67
    def background_worker=(_arg0); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#428
    def capture_event(event); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#392
    def capture_exception(exception, **options, &block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#420
    def capture_message(message, **options, &block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#322
    def clone_hub_to_current_thread; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#236
    def close; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#143
    def configuration; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#338
    def configure_scope(&block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#270
    def csp_report_uri; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#470
    def exception_captured?(exc); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#49
    def exception_locals_tp; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#306
    def get_current_client; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#295
    def get_current_hub; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#314
    def get_current_scope; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#278
    def get_main_hub; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#207
    def init(&block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#258
    def initialized?; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#107
    def integrations; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#462
    def last_event_id; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#503
    def logger; end

    # source://railties/7.0.6/lib/rails/engine.rb#405
    def railtie_helpers_paths; end

    # source://railties/7.0.6/lib/rails/engine.rb#394
    def railtie_namespace; end

    # source://railties/7.0.6/lib/rails/engine.rb#409
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#115
    def register_integration(name, version); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#76
    def register_patch(patch = T.unsafe(nil), target = T.unsafe(nil), &block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#98
    def registered_patches; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#508
    def sdk_meta; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#150
    def send_event(*args); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#71
    def session_flusher; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#196
    def set_context(*args); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#182
    def set_extras(*args); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#175
    def set_tags(*args); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#189
    def set_user(*args); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#436
    def start_transaction(**options); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#495
    def sys_command(command); end

    # source://railties/7.0.6/lib/rails/engine.rb#397
    def table_name_prefix; end

    # source://railties/7.0.6/lib/rails/engine.rb#401
    def use_relative_model_naming?; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#513
    def utc_now; end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#454
    def with_child_span(**attributes, &block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#409
    def with_exception_captured(**options, &block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#363
    def with_scope(&block); end

    # source://sentry-ruby/5.10.0/lib/sentry-ruby.rb#383
    def with_session_tracking(&block); end
  end
end

# source://sentry-rails//lib/sentry/rails/configuration.rb#7
class Sentry::Configuration
  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#306
  def initialize; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#24
  def app_dirs_pattern; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#24
  def app_dirs_pattern=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#31
  def async; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#360
  def async=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#244
  def auto_session_tracking; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#244
  def auto_session_tracking=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#41
  def background_worker_threads; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#41
  def background_worker_threads=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#52
  def backtrace_cleanup_callback; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#52
  def backtrace_cleanup_callback=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#61
  def before_breadcrumb; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#401
  def before_breadcrumb=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#75
  def before_send; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#389
  def before_send=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#88
  def before_send_transaction; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#395
  def before_send_transaction=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#100
  def breadcrumbs_logger; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#376
  def breadcrumbs_logger=(logger); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#143
  def capture_exception_frame_locals; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#149
  def capture_exception_frame_locals=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#108
  def context_lines; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#108
  def context_lines=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#482
  def csp_report_uri; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#117
  def debug; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#117
  def debug=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#503
  def detect_release; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#121
  def dsn; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#348
  def dsn=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#235
  def enable_tracing; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#415
  def enable_tracing=(enable_tracing); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#125
  def enabled_environments; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#125
  def enabled_environments=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#460
  def enabled_in_current_env?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#112
  def environment; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#407
  def environment=(environment); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#516
  def error_messages; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#258
  def errors; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#447
  def exception_class_allowed?(exc); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#129
  def exclude_loggers; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#129
  def exclude_loggers=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#134
  def excluded_exceptions; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#134
  def excluded_exceptions=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#258
  def gem_specs; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#143
  def include_local_variables; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#143
  def include_local_variables=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#138
  def inspect_exception_causes_for_exclusion; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#138
  def inspect_exception_causes_for_exclusion=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#138
  def inspect_exception_causes_for_exclusion?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#248
  def instrumenter; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#411
  def instrumenter=(instrumenter); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#420
  def is_numeric_or_nil?(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#161
  def linecache; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#161
  def linecache=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#166
  def logger; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#166
  def logger=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#104
  def max_breadcrumbs; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#104
  def max_breadcrumbs=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#254
  def profiles_sample_rate; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#429
  def profiles_sample_rate=(profiles_sample_rate); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#475
  def profiling_enabled?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#171
  def project_root; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#171
  def project_root=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#175
  def propagate_traces; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#175
  def propagate_traces=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#179
  def rack_env_whitelist; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#179
  def rack_env_whitelist=(_arg0); end

  # Returns the value of attribute rails.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#8
  def rails; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#184
  def release; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#354
  def release=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#441
  def sample_allowed?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#189
  def sample_rate; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#189
  def sample_rate=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#240
  def send_client_reports; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#240
  def send_client_reports=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#202
  def send_default_pii; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#202
  def send_default_pii=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#193
  def send_modules; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#193
  def send_modules=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#435
  def sending_allowed?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#348
  def server=(value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#212
  def server_name; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#212
  def server_name=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#206
  def skip_rake_integration; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#206
  def skip_rake_integration=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#492
  def stacktrace_builder; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#220
  def traces_sample_rate; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#424
  def traces_sample_rate=(traces_sample_rate); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#230
  def traces_sampler; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#230
  def traces_sampler=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#469
  def tracing_enabled?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#216
  def transport; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#209
  def trusted_proxies; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#209
  def trusted_proxies=(_arg0); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#464
  def valid_sample_rate?(sample_rate); end

  private

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#564
  def capture_in_environment?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#523
  def check_callable!(name, value); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#580
  def environment_from_env; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#535
  def excluded_exception?(incoming_exception); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#541
  def excluded_exception_classes; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#545
  def get_exception_class(x); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#529
  def init_dsn(dsn_string); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#549
  def matches_exception?(excluded_exception_class, incoming_exception); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#598
  def run_post_initialization_callbacks; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#594
  def running_on_heroku?; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#557
  def safe_const_get(x); end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#584
  def server_name_from_env; end

  # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#571
  def valid?; end

  class << self
    # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#301
    def add_post_initialization_callback(&block); end

    # source://sentry-ruby/5.10.0/lib/sentry/configuration.rb#296
    def post_initialization_callbacks; end
  end
end

# source://sentry-rails//lib/sentry/rails/engine.rb#2
class Sentry::Engine < ::Rails::Engine
  class << self
    # source://activesupport/7.0.6/lib/active_support/callbacks.rb#68
    def __callbacks; end
  end
end

# source://sentry-rails//lib/sentry/rails/version.rb#2
module Sentry::Rails
  extend ::Sentry::Integrable
end

# source://sentry-rails//lib/sentry/rails/backtrace_cleaner.rb#6
class Sentry::Rails::BacktraceCleaner < ::ActiveSupport::BacktraceCleaner
  # @return [BacktraceCleaner] a new instance of BacktraceCleaner
  #
  # source://sentry-rails//lib/sentry/rails/backtrace_cleaner.rb#10
  def initialize; end
end

# source://sentry-rails//lib/sentry/rails/backtrace_cleaner.rb#7
Sentry::Rails::BacktraceCleaner::APP_DIRS_PATTERN = T.let(T.unsafe(nil), Regexp)

# source://sentry-rails//lib/sentry/rails/backtrace_cleaner.rb#8
Sentry::Rails::BacktraceCleaner::RENDER_TEMPLATE_PATTERN = T.let(T.unsafe(nil), Regexp)

# source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#3
class Sentry::Rails::CaptureExceptions < ::Sentry::Rack::CaptureExceptions
  # @return [CaptureExceptions] a new instance of CaptureExceptions
  #
  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#6
  def initialize(_); end

  private

  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#25
  def capture_exception(exception, env); end

  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#16
  def collect_exception(env); end

  # @return [Boolean]
  #
  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#48
  def show_exceptions?(exception, env); end

  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#34
  def start_transaction(env, scope); end

  # source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#21
  def transaction_op; end
end

# source://sentry-rails//lib/sentry/rails/capture_exceptions.rb#4
Sentry::Rails::CaptureExceptions::RAILS_7_1 = T.let(T.unsafe(nil), FalseClass)

# source://sentry-rails//lib/sentry/rails/configuration.rb#44
class Sentry::Rails::Configuration
  # @return [Configuration] a new instance of Configuration
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#78
  def initialize; end

  # sentry-rails by default skips asset request' transactions by checking if the path matches
  #
  # ```rb
  # %r(\A/{0,2}#{::Rails.application.config.assets.prefix})
  # ```
  #
  # If you want to use a different pattern, you can configure the `assets_regexp` option like:
  #
  # ```rb
  # Sentry.init do |config|
  #   config.rails.assets_regexp = /my_regexp/
  # end
  # ```
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#76
  def assets_regexp; end

  # sentry-rails by default skips asset request' transactions by checking if the path matches
  #
  # ```rb
  # %r(\A/{0,2}#{::Rails.application.config.assets.prefix})
  # ```
  #
  # If you want to use a different pattern, you can configure the `assets_regexp` option like:
  #
  # ```rb
  # Sentry.init do |config|
  #   config.rails.assets_regexp = /my_regexp/
  # end
  # ```
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#76
  def assets_regexp=(_arg0); end

  # Rails 7.0 introduced a new error reporter feature, which the SDK once opted-in by default.
  # But after receiving multiple issue reports, the integration seemed to cause serious troubles to some users.
  # So the integration is now controlled by this configuration, which is disabled (false) by default.
  # More information can be found from: https://github.com/rails/rails/pull/43625#issuecomment-1072514175
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#49
  def register_error_subscriber; end

  # Rails 7.0 introduced a new error reporter feature, which the SDK once opted-in by default.
  # But after receiving multiple issue reports, the integration seemed to cause serious troubles to some users.
  # So the integration is now controlled by this configuration, which is disabled (false) by default.
  # More information can be found from: https://github.com/rails/rails/pull/43625#issuecomment-1072514175
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#49
  def register_error_subscriber=(_arg0); end

  # Rails catches exceptions in the ActionDispatch::ShowExceptions or
  # ActionDispatch::DebugExceptions middlewares, depending on the environment.
  # When `rails_report_rescued_exceptions` is true (it is by default), Sentry
  # will report exceptions even when they are rescued by these middlewares.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#55
  def report_rescued_exceptions; end

  # Rails catches exceptions in the ActionDispatch::ShowExceptions or
  # ActionDispatch::DebugExceptions middlewares, depending on the environment.
  # When `rails_report_rescued_exceptions` is true (it is by default), Sentry
  # will report exceptions even when they are rescued by these middlewares.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#55
  def report_rescued_exceptions=(_arg0); end

  # Some adapters, like sidekiq, already have their own sentry integration.
  # In those cases, we should skip ActiveJob's reporting to avoid duplicated reports.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#59
  def skippable_job_adapters; end

  # Some adapters, like sidekiq, already have their own sentry integration.
  # In those cases, we should skip ActiveJob's reporting to avoid duplicated reports.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#59
  def skippable_job_adapters=(_arg0); end

  # Returns the value of attribute tracing_subscribers.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#61
  def tracing_subscribers; end

  # Sets the attribute tracing_subscribers
  #
  # @param value the value to set the attribute tracing_subscribers to.
  #
  # source://sentry-rails//lib/sentry/rails/configuration.rb#61
  def tracing_subscribers=(_arg0); end
end

# source://sentry-rails//lib/sentry/rails/configuration.rb#28
Sentry::Rails::IGNORE_DEFAULT = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/instrument_payload_cleanup_helper.rb#3
module Sentry::Rails::InstrumentPayloadCleanupHelper
  # source://sentry-rails//lib/sentry/rails/instrument_payload_cleanup_helper.rb#6
  def cleanup_data(data); end
end

# source://sentry-rails//lib/sentry/rails/instrument_payload_cleanup_helper.rb#4
Sentry::Rails::InstrumentPayloadCleanupHelper::IGNORED_DATA_TYPES = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/rescued_exception_interceptor.rb#3
class Sentry::Rails::RescuedExceptionInterceptor
  # @return [RescuedExceptionInterceptor] a new instance of RescuedExceptionInterceptor
  #
  # source://sentry-rails//lib/sentry/rails/rescued_exception_interceptor.rb#4
  def initialize(app); end

  # source://sentry-rails//lib/sentry/rails/rescued_exception_interceptor.rb#8
  def call(env); end

  # @return [Boolean]
  #
  # source://sentry-rails//lib/sentry/rails/rescued_exception_interceptor.rb#19
  def report_rescued_exceptions?; end
end

# source://sentry-rails//lib/sentry/rails/tracing.rb#3
module Sentry::Rails::Tracing
  class << self
    # source://sentry-rails//lib/sentry/rails/tracing.rb#69
    def get_current_transaction; end

    # this is necessary because instrumentation events don't record absolute start/finish time
    # so we need to retrieve the correct time this way
    #
    # source://sentry-rails//lib/sentry/rails/tracing.rb#42
    def patch_active_support_notifications; end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#6
    def register_subscribers(subscribers); end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#59
    def remove_active_support_notifications_patch; end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#18
    def subscribe_tracing_events; end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#14
    def subscribed_tracing_events; end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#10
    def subscribers; end

    # source://sentry-rails//lib/sentry/rails/tracing.rb#31
    def unsubscribe_tracing_events; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/abstract_subscriber.rb#4
class Sentry::Rails::Tracing::AbstractSubscriber
  class << self
    # source://sentry-rails//lib/sentry/rails/tracing/abstract_subscriber.rb#40
    def record_on_current_span(duration:, **options); end

    # @raise [NotImplementedError]
    #
    # source://sentry-rails//lib/sentry/rails/tracing/abstract_subscriber.rb#7
    def subscribe!; end

    # source://sentry-rails//lib/sentry/rails/tracing/abstract_subscriber.rb#29
    def subscribe_to_event(event_names); end

    # source://sentry-rails//lib/sentry/rails/tracing/abstract_subscriber.rb#11
    def unsubscribe!; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/action_controller_subscriber.rb#7
class Sentry::Rails::Tracing::ActionControllerSubscriber < ::Sentry::Rails::Tracing::AbstractSubscriber
  extend ::Sentry::Rails::InstrumentPayloadCleanupHelper

  class << self
    # source://sentry-rails//lib/sentry/rails/tracing/action_controller_subscriber.rb#13
    def subscribe!; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/action_controller_subscriber.rb#10
Sentry::Rails::Tracing::ActionControllerSubscriber::EVENT_NAMES = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/tracing/action_controller_subscriber.rb#11
Sentry::Rails::Tracing::ActionControllerSubscriber::OP_NAME = T.let(T.unsafe(nil), String)

# source://sentry-rails//lib/sentry/rails/tracing/action_view_subscriber.rb#6
class Sentry::Rails::Tracing::ActionViewSubscriber < ::Sentry::Rails::Tracing::AbstractSubscriber
  class << self
    # source://sentry-rails//lib/sentry/rails/tracing/action_view_subscriber.rb#10
    def subscribe!; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/action_view_subscriber.rb#7
Sentry::Rails::Tracing::ActionViewSubscriber::EVENT_NAMES = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/tracing/action_view_subscriber.rb#8
Sentry::Rails::Tracing::ActionViewSubscriber::SPAN_PREFIX = T.let(T.unsafe(nil), String)

# source://sentry-rails//lib/sentry/rails/tracing/active_record_subscriber.rb#6
class Sentry::Rails::Tracing::ActiveRecordSubscriber < ::Sentry::Rails::Tracing::AbstractSubscriber
  class << self
    # source://sentry-rails//lib/sentry/rails/tracing/active_record_subscriber.rb#11
    def subscribe!; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/active_record_subscriber.rb#7
Sentry::Rails::Tracing::ActiveRecordSubscriber::EVENT_NAMES = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/tracing/active_record_subscriber.rb#9
Sentry::Rails::Tracing::ActiveRecordSubscriber::EXCLUDED_EVENTS = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/tracing/active_record_subscriber.rb#8
Sentry::Rails::Tracing::ActiveRecordSubscriber::SPAN_PREFIX = T.let(T.unsafe(nil), String)

# source://sentry-rails//lib/sentry/rails/tracing/active_storage_subscriber.rb#6
class Sentry::Rails::Tracing::ActiveStorageSubscriber < ::Sentry::Rails::Tracing::AbstractSubscriber
  class << self
    # source://sentry-rails//lib/sentry/rails/tracing/active_storage_subscriber.rb#22
    def subscribe!; end
  end
end

# source://sentry-rails//lib/sentry/rails/tracing/active_storage_subscriber.rb#7
Sentry::Rails::Tracing::ActiveStorageSubscriber::EVENT_NAMES = T.let(T.unsafe(nil), Array)

# source://sentry-rails//lib/sentry/rails/tracing.rb#4
Sentry::Rails::Tracing::START_TIMESTAMP_NAME = T.let(T.unsafe(nil), Symbol)

# it's just a container for the extended method
#
# source://sentry-rails//lib/sentry/rails/tracing.rb#74
module Sentry::Rails::Tracing::SentryNotificationExtension; end

# source://sentry-rails//lib/sentry/rails/version.rb#3
Sentry::Rails::VERSION = T.let(T.unsafe(nil), String)

# source://sentry-rails//lib/sentry/rails/railtie.rb#7
class Sentry::Railtie < ::Rails::Railtie
  # source://sentry-rails//lib/sentry/rails/railtie.rb#119
  def activate_tracing; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#65
  def configure_project_root; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#69
  def configure_trusted_proxies; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#73
  def extend_controller_methods; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#89
  def inject_breadcrumbs_logger; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#111
  def override_streaming_reporter; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#85
  def patch_background_worker; end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#128
  def register_error_subscriber(app); end

  # source://sentry-rails//lib/sentry/rails/railtie.rb#103
  def setup_backtrace_cleanup_callback; end
end

class Sentry::SendEventJob < ::ActiveJob::Base
  def perform(event, hint = T.unsafe(nil)); end

  class << self
    # source://activejob/7.0.6/lib/active_job/logging.rb#12
    def log_arguments; end

    # source://activesupport/7.0.6/lib/active_support/rescuable.rb#13
    def rescue_handlers; end
  end
end
