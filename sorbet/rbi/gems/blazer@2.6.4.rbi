# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `blazer` gem.
# Please instead update this file by running `bin/tapioca gem blazer`.

module Blazer
  class << self
    def adapters; end

    # Returns the value of attribute anomaly_checks.
    def anomaly_checks; end

    # Sets the attribute anomaly_checks
    #
    # @param value the value to set the attribute anomaly_checks to.
    def anomaly_checks=(_arg0); end

    def archive_queries; end

    # Returns the value of attribute async.
    def async; end

    # Sets the attribute async
    #
    # @param value the value to set the attribute async to.
    def async=(_arg0); end

    # Returns the value of attribute audit.
    def audit; end

    # Sets the attribute audit
    #
    # @param value the value to set the attribute audit to.
    def audit=(_arg0); end

    # Returns the value of attribute before_action.
    def before_action; end

    # Sets the attribute before_action
    #
    # @param value the value to set the attribute before_action to.
    def before_action=(_arg0); end

    # Returns the value of attribute cache.
    def cache; end

    # Sets the attribute cache
    #
    # @param value the value to set the attribute cache to.
    def cache=(_arg0); end

    # Returns the value of attribute check_schedules.
    def check_schedules; end

    # Sets the attribute check_schedules
    #
    # @param value the value to set the attribute check_schedules to.
    def check_schedules=(_arg0); end

    def data_sources; end

    # TODO move to Statement and remove in 3.0.0
    def extract_vars(statement); end

    # Returns the value of attribute forecasting.
    def forecasting; end

    # Sets the attribute forecasting
    #
    # @param value the value to set the attribute forecasting to.
    def forecasting=(_arg0); end

    # Returns the value of attribute from_email.
    def from_email; end

    # Sets the attribute from_email
    #
    # @param value the value to set the attribute from_email to.
    def from_email=(_arg0); end

    # Returns the value of attribute images.
    def images; end

    # Sets the attribute images
    #
    # @param value the value to set the attribute images to.
    def images=(_arg0); end

    # Returns the value of attribute mapbox_access_token.
    def mapbox_access_token; end

    # Sets the attribute mapbox_access_token
    #
    # @param value the value to set the attribute mapbox_access_token to.
    def mapbox_access_token=(_arg0); end

    # Returns the value of attribute override_csp.
    def override_csp; end

    # Sets the attribute override_csp
    #
    # @param value the value to set the attribute override_csp to.
    def override_csp=(_arg0); end

    # Returns the value of attribute query_editable.
    def query_editable; end

    # Sets the attribute query_editable
    #
    # @param value the value to set the attribute query_editable to.
    def query_editable=(_arg0); end

    # Returns the value of attribute query_viewable.
    def query_viewable; end

    # Sets the attribute query_viewable
    #
    # @param value the value to set the attribute query_viewable to.
    def query_viewable=(_arg0); end

    def railtie_helpers_paths; end
    def railtie_namespace; end
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end
    def register_adapter(name, adapter); end
    def run_check(check); end
    def run_checks(schedule: T.unsafe(nil)); end
    def send_failing_checks; end
    def settings; end

    # @return [Boolean]
    def slack?; end

    # Returns the value of attribute slack_oauth_token.
    def slack_oauth_token; end

    # Sets the attribute slack_oauth_token
    #
    # @param value the value to set the attribute slack_oauth_token to.
    def slack_oauth_token=(_arg0); end

    # Returns the value of attribute slack_webhook_url.
    def slack_webhook_url; end

    # Sets the attribute slack_webhook_url
    #
    # @param value the value to set the attribute slack_webhook_url to.
    def slack_webhook_url=(_arg0); end

    def table_name_prefix; end

    # Returns the value of attribute time_zone.
    def time_zone; end

    def time_zone=(time_zone); end

    # Returns the value of attribute transform_statement.
    def transform_statement; end

    # Sets the attribute transform_statement
    #
    # @param value the value to set the attribute transform_statement to.
    def transform_statement=(_arg0); end

    # Returns the value of attribute transform_variable.
    def transform_variable; end

    # Sets the attribute transform_variable
    #
    # @param value the value to set the attribute transform_variable to.
    def transform_variable=(_arg0); end

    # @return [Boolean]
    def uploads?; end

    def uploads_connection; end
    def uploads_schema; end
    def uploads_table_name(name); end
    def use_relative_model_naming?; end
    def user_class; end

    # Sets the attribute user_class
    #
    # @param value the value to set the attribute user_class to.
    def user_class=(_arg0); end

    def user_method; end

    # Sets the attribute user_method
    #
    # @param value the value to set the attribute user_method to.
    def user_method=(_arg0); end

    # Returns the value of attribute user_name.
    def user_name; end

    # Sets the attribute user_name
    #
    # @param value the value to set the attribute user_name to.
    def user_name=(_arg0); end
  end
end

module Blazer::Adapters; end

class Blazer::Adapters::AthenaAdapter < ::Blazer::Adapters::BaseAdapter
  # https://docs.aws.amazon.com/athena/latest/ug/querying-with-prepared-statements.html
  def parameter_binding; end

  def preview_statement; end

  # https://docs.aws.amazon.com/athena/latest/ug/select.html#select-escaping
  def quoting; end

  def run_statement(statement, comment, bind_params = T.unsafe(nil)); end
  def schema; end
  def tables; end

  private

  def client; end
  def client_options; end
  def database; end

  # note: this setting is experimental
  # it does *not* need to be set to use engine version 2
  # prepared statements must be manually deleted if enabled
  def engine_version; end

  def fetch_error(query_execution_id); end
  def glue; end
end

class Blazer::Adapters::BaseAdapter
  # @return [BaseAdapter] a new instance of BaseAdapter
  def initialize(data_source); end

  # @return [Boolean]
  def cachable?(statement); end

  def cancel(run_id); end
  def cohort_analysis_statement(statement, period:, days:); end
  def cost(statement); end

  # Returns the value of attribute data_source.
  def data_source; end

  def explain(statement); end
  def parameter_binding; end
  def preview_statement; end
  def quoting; end
  def reconnect; end
  def run_statement(statement, comment); end
  def schema; end

  # @return [Boolean]
  def supports_cohort_analysis?; end

  def tables; end

  protected

  def settings; end
end

class Blazer::Adapters::BigQueryAdapter < ::Blazer::Adapters::BaseAdapter
  # https://cloud.google.com/bigquery/docs/parameterized-queries
  def parameter_binding; end

  def preview_statement; end

  # https://cloud.google.com/bigquery/docs/reference/standard-sql/lexical#string_and_bytes_literals
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def schema; end
  def tables; end

  private

  def bigquery; end
  def table_columns(table_ref); end
  def table_refs; end
end

class Blazer::Adapters::CassandraAdapter < ::Blazer::Adapters::BaseAdapter
  # https://docs.datastax.com/en/developer/nodejs-driver/3.0/features/parameterized-queries/
  def parameter_binding; end

  def preview_statement; end

  # https://docs.datastax.com/en/cql-oss/3.3/cql/cql_reference/escape_char_r.html
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def schema; end
  def tables; end

  private

  def cluster; end
  def keyspace; end
  def session; end
  def uri; end
end

class Blazer::Adapters::DrillAdapter < ::Blazer::Adapters::BaseAdapter
  # https://issues.apache.org/jira/browse/DRILL-5079
  def parameter_binding; end

  # https://drill.apache.org/docs/lexical-structure/#string
  def quoting; end

  def run_statement(statement, comment); end

  private

  def drill; end
end

class Blazer::Adapters::DruidAdapter < ::Blazer::Adapters::BaseAdapter
  # https://druid.apache.org/docs/latest/querying/sql.html#dynamic-parameters
  def parameter_binding; end

  def preview_statement; end

  # https://druid.apache.org/docs/latest/querying/sql.html#identifiers-and-literals
  # docs only mention double quotes
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def schema; end
  def tables; end
end

Blazer::Adapters::DruidAdapter::TIMESTAMP_REGEX = T.let(T.unsafe(nil), Regexp)

class Blazer::Adapters::ElasticsearchAdapter < ::Blazer::Adapters::BaseAdapter
  # https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-rest-params.html
  def parameter_binding; end

  def preview_statement; end

  # https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-lexical-structure.html#sql-syntax-string-literals
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def tables; end

  protected

  def client; end
  def endpoint; end
end

class Blazer::Adapters::HiveAdapter < ::Blazer::Adapters::BaseAdapter
  # has variable substitution, but sets for session
  # https://cwiki.apache.org/confluence/display/Hive/LanguageManual+VariableSubstitution
  def parameter_binding; end

  def preview_statement; end

  # https://cwiki.apache.org/confluence/display/Hive/LanguageManual+Types#LanguageManualTypes-StringsstringStrings
  def quoting; end

  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
end

class Blazer::Adapters::IgniteAdapter < ::Blazer::Adapters::BaseAdapter
  # query arguments
  # https://ignite.apache.org/docs/latest/binary-client-protocol/sql-and-scan-queries#op_query_sql
  def parameter_binding; end

  def preview_statement; end

  # TODO figure out error
  # Table `__T0` can be accessed only within Ignite query context.
  # def schema
  #   sql = "SELECT table_schema, table_name, column_name, data_type, ordinal_position FROM information_schema.columns WHERE table_schema NOT IN ('INFORMATION_SCHEMA', 'SYS')"
  #   result = data_source.run_statement(sql)
  #   result.rows.group_by { |r| [r[0], r[1]] }.map { |k, vs| {schema: k[0], table: k[1], columns: vs.sort_by { |v| v[2] }.map { |v| {name: v[2], data_type: v[3]} }} }.sort_by { |t| [t[:schema] == default_schema ? "" : t[:schema], t[:table]] }
  # end
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def tables; end

  private

  def client; end
  def default_schema; end
end

class Blazer::Adapters::InfluxdbAdapter < ::Blazer::Adapters::BaseAdapter
  def parameter_binding; end
  def preview_statement; end

  # https://docs.influxdata.com/influxdb/v1.8/query_language/spec/#strings
  def quoting; end

  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
end

class Blazer::Adapters::MongodbAdapter < ::Blazer::Adapters::BaseAdapter
  def preview_statement; end
  def quoting; end
  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
  def db; end
end

class Blazer::Adapters::Neo4jAdapter < ::Blazer::Adapters::BaseAdapter
  def parameter_binding; end
  def preview_statement; end

  # https://neo4j.com/docs/cypher-manual/current/syntax/expressions/#cypher-expressions-string-literals
  def quoting; end

  def run_statement(statement, comment, bind_params); end
  def tables; end

  protected

  def session; end
end

class Blazer::Adapters::OpensearchAdapter < ::Blazer::Adapters::BaseAdapter
  def preview_statement; end
  def quoting; end
  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
end

class Blazer::Adapters::PrestoAdapter < ::Blazer::Adapters::BaseAdapter
  # TODO support prepared statements - https://prestodb.io/docs/current/sql/prepare.html
  # feature request for variables - https://github.com/prestodb/presto/issues/5918
  def parameter_binding; end

  def preview_statement; end
  def quoting; end
  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
end

class Blazer::Adapters::SalesforceAdapter < ::Blazer::Adapters::BaseAdapter
  def preview_statement; end

  # https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_quotedstringescapes.htm
  def quoting; end

  def run_statement(statement, comment); end
  def tables; end

  protected

  def client; end
end

class Blazer::Adapters::SnowflakeAdapter < ::Blazer::Adapters::SqlAdapter
  # @return [SnowflakeAdapter] a new instance of SnowflakeAdapter
  def initialize(data_source); end

  def cancel(run_id); end
  def parameter_binding; end

  # https://docs.snowflake.com/en/sql-reference/data-types-text.html#escape-sequences
  def quoting; end
end

class Blazer::Adapters::SodaAdapter < ::Blazer::Adapters::BaseAdapter
  def preview_statement; end

  # https://dev.socrata.com/docs/datatypes/text.html
  def quoting; end

  def run_statement(statement, comment); end
  def tables; end
end

class Blazer::Adapters::SparkAdapter < ::Blazer::Adapters::HiveAdapter
  # https://spark.apache.org/docs/latest/sql-ref-literals.html
  def quoting; end

  def tables; end
end

class Blazer::Adapters::SqlAdapter < ::Blazer::Adapters::BaseAdapter
  # @return [SqlAdapter] a new instance of SqlAdapter
  def initialize(data_source); end

  # @return [Boolean]
  def cachable?(statement); end

  def cancel(run_id); end

  # TODO treat date columns as already in time zone
  def cohort_analysis_statement(statement, period:, days:); end

  # Returns the value of attribute connection_model.
  def connection_model; end

  def cost(statement); end
  def explain(statement); end

  # Redshift adapter silently ignores binds
  def parameter_binding; end

  def preview_statement; end
  def quoting; end
  def reconnect; end
  def run_statement(statement, comment, bind_params = T.unsafe(nil)); end
  def schema; end

  # @return [Boolean]
  def supports_cohort_analysis?; end

  def tables; end

  protected

  def adapter_name; end
  def add_schemas(query); end
  def default_schema; end

  # seperate from select_all to prevent mysql error
  def execute(statement); end

  def in_transaction; end

  # @return [Boolean]
  def mysql?; end

  # @return [Boolean]
  def postgresql?; end

  # @return [Boolean]
  def prepared_statements?; end

  # @return [Boolean]
  def redshift?; end

  def select_all(statement, params = T.unsafe(nil)); end
  def set_timeout(timeout); end

  # @return [Boolean]
  def snowflake?; end

  # @return [Boolean]
  def sqlite?; end

  # @return [Boolean]
  def sqlserver?; end

  # @return [Boolean]
  def use_transaction?; end
end

class Blazer::Audit < ::Blazer::Record
  include ::Blazer::Audit::GeneratedAttributeMethods
  include ::Blazer::Audit::GeneratedAssociationMethods

  def autosave_associated_records_for_query(*args); end
  def autosave_associated_records_for_user(*args); end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def defined_enums; end
  end
end

module Blazer::Audit::GeneratedAssociationMethods
  def build_query(*args, &block); end
  def build_user(*args, &block); end
  def create_query(*args, &block); end
  def create_query!(*args, &block); end
  def create_user(*args, &block); end
  def create_user!(*args, &block); end
  def query; end
  def query=(value); end
  def query_changed?; end
  def query_previously_changed?; end
  def reload_query; end
  def reload_user; end
  def user; end
  def user=(value); end
  def user_changed?; end
  def user_previously_changed?; end
end

module Blazer::Audit::GeneratedAttributeMethods; end

class Blazer::BaseController < ::ApplicationController
  private

  def _layout(lookup_context, formats); end
  def add_cohort_analysis_vars; end
  def blazer_user; end
  def cohort_analysis_statement(statement); end
  def default_url_options; end
  def parse_smart_variables(var, data_source); end
  def process_vars(statement, var_params = T.unsafe(nil)); end
  def refresh_query(query); end
  def render_errors(resource); end
  def variable_params(resource, var_params = T.unsafe(nil)); end

  class << self
    def __callbacks; end
    def _helper_methods; end
    def _layout; end
    def _layout_conditions; end
    def middleware_stack; end
  end
end

Blazer::BaseController::UNPERMITTED_KEYS = T.let(T.unsafe(nil), Array)

module Blazer::BaseHelper
  def blazer_format_value(key, value); end
  def blazer_js_var(name, value); end
  def blazer_maps?; end
  def blazer_series_name(k); end
  def blazer_title(title = T.unsafe(nil)); end
end

Blazer::BaseHelper::BLAZER_IMAGE_EXT = T.let(T.unsafe(nil), Array)
Blazer::BaseHelper::BLAZER_URL_REGEX = T.let(T.unsafe(nil), Regexp)

class Blazer::Check < ::Blazer::Record
  include ::Blazer::Check::GeneratedAttributeMethods
  include ::Blazer::Check::GeneratedAssociationMethods

  def autosave_associated_records_for_creator(*args); end
  def autosave_associated_records_for_query(*args); end
  def split_emails; end
  def split_slack_channels; end
  def update_state(result); end

  private

  def fix_emails; end
  def set_state; end
  def validate_emails; end
  def validate_variables; end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def defined_enums; end
  end
end

module Blazer::Check::GeneratedAssociationMethods
  def build_creator(*args, &block); end
  def build_query(*args, &block); end
  def create_creator(*args, &block); end
  def create_creator!(*args, &block); end
  def create_query(*args, &block); end
  def create_query!(*args, &block); end
  def creator; end
  def creator=(value); end
  def creator_changed?; end
  def creator_previously_changed?; end
  def query; end
  def query=(value); end
  def query_changed?; end
  def query_previously_changed?; end
  def reload_creator; end
  def reload_query; end
end

module Blazer::Check::GeneratedAttributeMethods; end

class Blazer::CheckMailer < ::ActionMailer::Base
  include ::ActionView::Helpers::SanitizeHelper
  include ::ActionView::Helpers::CaptureHelper
  include ::ActionView::Helpers::OutputSafetyHelper
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::TextHelper
  extend ::ActionView::Helpers::SanitizeHelper::ClassMethods

  def failing_checks(email, checks); end
  def state_change(check, state, state_was, rows_count, error, columns, rows, column_types, check_type); end

  private

  def _layout(lookup_context, formats); end

  class << self
    def _layout; end
    def _layout_conditions; end
  end
end

class Blazer::ChecksController < ::Blazer::BaseController
  def create; end
  def destroy; end
  def index; end
  def new; end
  def run; end
  def update; end

  private

  def _layout(lookup_context, formats); end
  def check_params; end
  def set_check; end

  class << self
    def __callbacks; end
    def middleware_stack; end
  end
end

class Blazer::Connection < ::ActiveRecord::Base
  include ::Blazer::Connection::GeneratedAttributeMethods
  include ::Blazer::Connection::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  class << self
    def _validators; end
    def defined_enums; end
    def page(num = T.unsafe(nil)); end
  end
end

module Blazer::Connection::GeneratedAssociationMethods; end
module Blazer::Connection::GeneratedAttributeMethods; end

class Blazer::Dashboard < ::Blazer::Record
  include ::Blazer::Dashboard::GeneratedAttributeMethods
  include ::Blazer::Dashboard::GeneratedAssociationMethods

  def autosave_associated_records_for_creator(*args); end
  def autosave_associated_records_for_dashboard_queries(*args); end
  def autosave_associated_records_for_queries(*args); end
  def to_param; end
  def validate_associated_records_for_dashboard_queries(*args); end
  def validate_associated_records_for_queries(*args); end
  def variables; end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def defined_enums; end
  end
end

module Blazer::Dashboard::GeneratedAssociationMethods
  def build_creator(*args, &block); end
  def create_creator(*args, &block); end
  def create_creator!(*args, &block); end
  def creator; end
  def creator=(value); end
  def creator_changed?; end
  def creator_previously_changed?; end
  def dashboard_queries; end
  def dashboard_queries=(value); end
  def dashboard_query_ids; end
  def dashboard_query_ids=(ids); end
  def queries; end
  def queries=(value); end
  def query_ids; end
  def query_ids=(ids); end
  def reload_creator; end
end

module Blazer::Dashboard::GeneratedAttributeMethods; end

class Blazer::DashboardQuery < ::Blazer::Record
  include ::Blazer::DashboardQuery::GeneratedAttributeMethods
  include ::Blazer::DashboardQuery::GeneratedAssociationMethods

  def autosave_associated_records_for_dashboard(*args); end
  def autosave_associated_records_for_query(*args); end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def defined_enums; end
  end
end

module Blazer::DashboardQuery::GeneratedAssociationMethods
  def build_dashboard(*args, &block); end
  def build_query(*args, &block); end
  def create_dashboard(*args, &block); end
  def create_dashboard!(*args, &block); end
  def create_query(*args, &block); end
  def create_query!(*args, &block); end
  def dashboard; end
  def dashboard=(value); end
  def dashboard_changed?; end
  def dashboard_previously_changed?; end
  def query; end
  def query=(value); end
  def query_changed?; end
  def query_previously_changed?; end
  def reload_dashboard; end
  def reload_query; end
end

module Blazer::DashboardQuery::GeneratedAttributeMethods; end

class Blazer::DashboardsController < ::Blazer::BaseController
  def create; end
  def destroy; end
  def edit; end
  def new; end
  def refresh; end
  def show; end
  def update; end

  private

  def _layout(lookup_context, formats); end
  def dashboard_params; end
  def set_dashboard; end
  def update_dashboard(dashboard); end

  class << self
    def __callbacks; end
    def middleware_stack; end
  end
end

class Blazer::DataSource
  extend ::Forwardable

  # @return [DataSource] a new instance of DataSource
  def initialize(id, settings); end

  def adapter; end
  def bind_params(statement, variables); end
  def cache; end
  def cache_expires_in; end
  def cache_key(key); end
  def cache_mode; end
  def cache_slow_threshold; end
  def cancel(*args, &block); end
  def clear_cache(statement); end
  def cohort_analysis_statement(*args, &block); end
  def cost(*args, &block); end
  def delete_results(run_id); end
  def explain(*args, &block); end

  # Returns the value of attribute id.
  def id; end

  def linked_columns; end
  def local_time_suffix; end
  def name; end
  def preview_statement(*args, &block); end
  def quote(value); end
  def read_cache(cache_key); end
  def reconnect(*args, &block); end
  def run_cache_key(run_id); end
  def run_results(run_id); end
  def run_statement(statement, options = T.unsafe(nil)); end
  def schema(*args, &block); end

  # Returns the value of attribute settings.
  def settings; end

  def smart_columns; end
  def smart_variables; end
  def statement_cache_key(statement); end
  def sub_variables(statement, vars); end
  def supports_cohort_analysis?(*args, &block); end
  def tables(*args, &block); end
  def timeout; end
  def variable_defaults; end

  protected

  def adapter_instance; end

  # TODO check for adapter with same name, default to sql
  def detect_adapter; end

  def parameter_binding; end
  def quoting; end
  def run_statement_helper(statement, comment, run_id, options); end
end

class Blazer::Engine < ::Rails::Engine; end
class Blazer::Error < ::StandardError; end

class Blazer::QueriesController < ::Blazer::BaseController
  def cancel; end
  def create; end
  def destroy; end
  def docs; end
  def edit; end
  def home; end
  def index; end
  def new; end
  def refresh; end
  def run; end
  def schema; end
  def show; end
  def tables; end
  def update; end

  private

  def _layout(lookup_context, formats); end
  def blazer_params; end
  def blazer_run_id; end
  def blazer_time_value(data_source, k, v); end
  def continue_run; end
  def csv_data(columns, rows, data_source); end
  def queries_by_ids(favorite_query_ids); end
  def query_params; end
  def render_cohort_analysis; end
  def render_forbidden; end
  def render_run; end
  def run_cohort_analysis; end
  def set_data_source; end
  def set_queries(limit = T.unsafe(nil)); end
  def set_query; end

  class << self
    def __callbacks; end
    def _helper_methods; end
    def middleware_stack; end
  end
end

module Blazer::QueriesController::HelperMethods
  def blazer_time_value(*args, &block); end
end

class Blazer::Query < ::Blazer::Record
  include ::Blazer::Query::GeneratedAttributeMethods
  include ::Blazer::Query::GeneratedAssociationMethods

  def autosave_associated_records_for_audits(*args); end
  def autosave_associated_records_for_checks(*args); end
  def autosave_associated_records_for_creator(*args); end
  def autosave_associated_records_for_dashboard_queries(*args); end
  def autosave_associated_records_for_dashboards(*args); end
  def cohort_analysis?; end
  def editable?(user); end
  def friendly_name; end
  def statement_object; end
  def to_param; end
  def validate_associated_records_for_audits(*args); end
  def validate_associated_records_for_checks(*args); end
  def validate_associated_records_for_dashboard_queries(*args); end
  def validate_associated_records_for_dashboards(*args); end
  def variables; end
  def viewable?(user); end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def active(*args); end
    def defined_enums; end
    def named(*args); end
  end
end

module Blazer::Query::GeneratedAssociationMethods
  def audit_ids; end
  def audit_ids=(ids); end
  def audits; end
  def audits=(value); end
  def build_creator(*args, &block); end
  def check_ids; end
  def check_ids=(ids); end
  def checks; end
  def checks=(value); end
  def create_creator(*args, &block); end
  def create_creator!(*args, &block); end
  def creator; end
  def creator=(value); end
  def creator_changed?; end
  def creator_previously_changed?; end
  def dashboard_ids; end
  def dashboard_ids=(ids); end
  def dashboard_queries; end
  def dashboard_queries=(value); end
  def dashboard_query_ids; end
  def dashboard_query_ids=(ids); end
  def dashboards; end
  def dashboards=(value); end
  def reload_creator; end
end

module Blazer::Query::GeneratedAttributeMethods; end

class Blazer::Record < ::ActiveRecord::Base
  include ::Blazer::Record::GeneratedAttributeMethods
  include ::Blazer::Record::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  class << self
    def _validators; end
    def defined_enums; end
    def page(num = T.unsafe(nil)); end
  end
end

module Blazer::Record::GeneratedAssociationMethods; end
module Blazer::Record::GeneratedAttributeMethods; end

class Blazer::Result
  # @return [Result] a new instance of Result
  def initialize(data_source, columns, rows, error, cached_at, just_cached); end

  # @return [Boolean]
  def anomaly?(series); end

  def boom; end

  # @return [Boolean]
  def cached?; end

  # Returns the value of attribute cached_at.
  def cached_at; end

  def chart_type; end
  def column_types; end

  # Returns the value of attribute columns.
  def columns; end

  # Returns the value of attribute data_source.
  def data_source; end

  def detect_anomaly; end

  # Returns the value of attribute error.
  def error; end

  # TODO cache it?
  # don't want to put result data (even hashed version)
  # into cache without developer opt-in
  def forecast; end

  # Returns the value of attribute forecast_error.
  def forecast_error; end

  # @return [Boolean]
  def forecastable?; end

  # Returns the value of attribute just_cached.
  def just_cached; end

  # Returns the value of attribute rows.
  def rows; end

  # @return [Boolean]
  def timed_out?; end
end

class Blazer::RunStatement
  def perform(statement, options = T.unsafe(nil)); end
end

class Blazer::RunStatementJob < ::ActiveJob::Base
  def perform(data_source_id, statement, options); end

  class << self
    def _queue_adapter; end
    def _queue_adapter_name; end
  end
end

class Blazer::SlackNotifier
  class << self
    # https://api.slack.com/docs/message-formatting#how_to_escape_characters
    # - Replace the ampersand, &, with &amp;
    # - Replace the less-than sign, < with &lt;
    # - Replace the greater-than sign, > with &gt;
    # That's it. Don't HTML entity-encode the entire message.
    def escape(str); end

    def failing_checks(channel, checks); end
    def pluralize(*args); end

    # TODO use return value
    def post(payload); end

    def post_api(url, payload, headers); end

    # checks shouldn't have variables, but in any case,
    # avoid passing variable params to url helpers
    # (known unsafe parameters are removed, but still not ideal)
    def query_url(id); end

    def state_change(check, state, state_was, rows_count, error, check_type); end
  end
end

class Blazer::Statement
  # @return [Statement] a new instance of Statement
  def initialize(statement, data_source = T.unsafe(nil)); end

  def add_values(var_params); end
  def apply_cohort_analysis(period:, days:); end
  def bind; end

  # Returns the value of attribute bind_statement.
  def bind_statement; end

  # Returns the value of attribute bind_values.
  def bind_values; end

  def clear_cache; end

  # @return [Boolean]
  def cohort_analysis?; end

  # Returns the value of attribute data_source.
  def data_source; end

  def display_statement; end

  # Returns the value of attribute statement.
  def statement; end

  # should probably transform before cohort analysis
  # but keep previous order for now
  def transformed_statement; end

  # Returns the value of attribute values.
  def values; end

  # Sets the attribute values
  #
  # @param value the value to set the attribute values to.
  def values=(_arg0); end

  def variables; end
end

Blazer::TIMEOUT_ERRORS = T.let(T.unsafe(nil), Array)
Blazer::TIMEOUT_MESSAGE = T.let(T.unsafe(nil), String)
class Blazer::TimeoutNotSupported < ::Blazer::Error; end

class Blazer::Upload < ::Blazer::Record
  include ::Blazer::Upload::GeneratedAttributeMethods
  include ::Blazer::Upload::GeneratedAssociationMethods

  def autosave_associated_records_for_creator(*args); end
  def table_name; end

  class << self
    def __callbacks; end
    def _reflections; end
    def _validators; end
    def defined_enums; end
  end
end

module Blazer::Upload::GeneratedAssociationMethods
  def build_creator(*args, &block); end
  def create_creator(*args, &block); end
  def create_creator!(*args, &block); end
  def creator; end
  def creator=(value); end
  def creator_changed?; end
  def creator_previously_changed?; end
  def reload_creator; end
end

module Blazer::Upload::GeneratedAttributeMethods; end
class Blazer::UploadError < ::Blazer::Error; end

class Blazer::UploadsConnection < ::ActiveRecord::Base
  include ::Blazer::UploadsConnection::GeneratedAttributeMethods
  include ::Blazer::UploadsConnection::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  class << self
    def _validators; end
    def defined_enums; end
    def page(num = T.unsafe(nil)); end
  end
end

module Blazer::UploadsConnection::GeneratedAssociationMethods; end
module Blazer::UploadsConnection::GeneratedAttributeMethods; end

class Blazer::UploadsController < ::Blazer::BaseController
  def create; end
  def destroy; end
  def edit; end
  def index; end
  def new; end
  def show; end
  def update; end

  private

  def _layout(lookup_context, formats); end
  def ensure_uploads; end
  def set_upload; end
  def update_file(upload, drop: T.unsafe(nil)); end
  def upload_params; end

  class << self
    def __callbacks; end
    def middleware_stack; end
  end
end

Blazer::VARIABLE_MESSAGE = T.let(T.unsafe(nil), String)
Blazer::VERSION = T.let(T.unsafe(nil), String)
