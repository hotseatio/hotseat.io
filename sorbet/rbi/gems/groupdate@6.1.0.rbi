# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `groupdate` gem.
# Please instead update this file by running `bin/tapioca gem groupdate`.

# for both multiple series and
# making sure hash order is preserved in JavaScript
module Enumerable
  extend ::ActiveSupport::EnumerableCoreExt::Constants

  def group_by_day(*args, **options, &block); end
  def group_by_day_of_month(*args, **options, &block); end
  def group_by_day_of_week(*args, **options, &block); end
  def group_by_day_of_year(*args, **options, &block); end
  def group_by_hour(*args, **options, &block); end
  def group_by_hour_of_day(*args, **options, &block); end
  def group_by_minute(*args, **options, &block); end
  def group_by_minute_of_hour(*args, **options, &block); end
  def group_by_month(*args, **options, &block); end
  def group_by_month_of_year(*args, **options, &block); end
  def group_by_period(period, *args, **options, &block); end
  def group_by_quarter(*args, **options, &block); end
  def group_by_second(*args, **options, &block); end
  def group_by_week(*args, **options, &block); end
  def group_by_year(*args, **options, &block); end
end

module Groupdate
  def day_start; end
  def day_start=(val); end
  def time_zone; end
  def time_zone=(val); end
  def week_start; end
  def week_start=(val); end

  class << self
    def adapters; end
    def day_start; end
    def day_start=(val); end

    # api for gems like ActiveMedian
    def process_result(relation, result, **options); end

    def register_adapter(name, adapter); end
    def time_zone; end
    def time_zone=(val); end
    def week_start; end
    def week_start=(val); end
  end
end

module Groupdate::Adapters; end

class Groupdate::Adapters::BaseAdapter
  # @return [BaseAdapter] a new instance of BaseAdapter
  def initialize(relation, column:, period:, time_zone:, time_range:, week_start:, day_start:, n_seconds:); end

  # Returns the value of attribute column.
  def column; end

  # Returns the value of attribute day_start.
  def day_start; end

  def generate; end

  # Returns the value of attribute n_seconds.
  def n_seconds; end

  # Returns the value of attribute period.
  def period; end

  # Returns the value of attribute week_start.
  def week_start; end

  private

  def where_clause; end
end

class Groupdate::Adapters::MySQLAdapter < ::Groupdate::Adapters::BaseAdapter
  def clean_group_clause(clause); end
  def group_clause; end
end

class Groupdate::Adapters::PostgreSQLAdapter < ::Groupdate::Adapters::BaseAdapter
  def clean_group_clause(clause); end
  def group_clause; end
end

class Groupdate::Adapters::SQLiteAdapter < ::Groupdate::Adapters::BaseAdapter
  # @raise [Groupdate::Error]
  def group_clause; end
end

class Groupdate::Error < ::RuntimeError; end
Groupdate::METHODS = T.let(T.unsafe(nil), Array)

class Groupdate::Magic
  # @return [Magic] a new instance of Magic
  def initialize(period:, **options); end

  def day_start; end

  # Returns the value of attribute group_index.
  def group_index; end

  # Sets the attribute group_index
  #
  # @param value the value to set the attribute group_index to.
  def group_index=(_arg0); end

  # Returns the value of attribute n_seconds.
  def n_seconds; end

  # Sets the attribute n_seconds
  #
  # @param value the value to set the attribute n_seconds to.
  def n_seconds=(_arg0); end

  # Returns the value of attribute options.
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  def options=(_arg0); end

  # Returns the value of attribute period.
  def period; end

  # Sets the attribute period
  #
  # @param value the value to set the attribute period to.
  def period=(_arg0); end

  def range; end
  def series_builder; end
  def time_range; end
  def time_zone; end

  # @raise [ArgumentError]
  def validate_arguments; end

  # @raise [ArgumentError]
  def validate_keywords; end

  def week_start; end

  class << self
    # @raise [ArgumentError]
    def validate_period(period, permit); end
  end
end

Groupdate::Magic::DAYS = T.let(T.unsafe(nil), Array)

class Groupdate::Magic::Enumerable < ::Groupdate::Magic
  def group_by(enum, &_block); end

  class << self
    def group_by(enum, period, options, &block); end
  end
end

class Groupdate::Magic::Relation < ::Groupdate::Magic
  # @return [Relation] a new instance of Relation
  def initialize(**options); end

  def cast_method; end
  def cast_result(result, multiple_groups); end
  def check_nils(result, multiple_groups, relation); end
  def perform(relation, result, default_value:); end

  # @return [Boolean]
  def time_zone_support?(relation); end

  class << self
    # @raise [Groupdate::Error]
    def generate_relation(relation, field:, **options); end

    # allow any options to keep flexible for future
    def process_result(relation, result, **options); end

    # resolves eagerly
    # need to convert both where_clause (easy)
    # and group_clause (not easy) if want to avoid this
    def resolve_column(relation, column); end

    # basic version of Active Record disallow_raw_sql!
    # symbol = column (safe), Arel node = SQL (safe), other = untrusted
    # matches table.column and column
    def validate_column(column); end
  end
end

Groupdate::PERIODS = T.let(T.unsafe(nil), Array)

module Groupdate::QueryMethods
  def group_by_day(field, **options); end
  def group_by_day_of_month(field, **options); end
  def group_by_day_of_week(field, **options); end
  def group_by_day_of_year(field, **options); end
  def group_by_hour(field, **options); end
  def group_by_hour_of_day(field, **options); end
  def group_by_minute(field, **options); end
  def group_by_minute_of_hour(field, **options); end
  def group_by_month(field, **options); end
  def group_by_month_of_year(field, **options); end
  def group_by_period(period, field, permit: T.unsafe(nil), **options); end
  def group_by_quarter(field, **options); end
  def group_by_second(field, **options); end
  def group_by_week(field, **options); end
  def group_by_year(field, **options); end
end

module Groupdate::Relation
  extend ::ActiveSupport::Concern

  def calculate(*args, &block); end
end

class Groupdate::SeriesBuilder
  # @return [SeriesBuilder] a new instance of SeriesBuilder
  def initialize(period:, time_zone:, day_start:, week_start:, n_seconds:, **options); end

  # Returns the value of attribute day_start.
  def day_start; end

  def generate(data, default_value:, series_default: T.unsafe(nil), multiple_groups: T.unsafe(nil), group_index: T.unsafe(nil)); end

  # Returns the value of attribute n_seconds.
  def n_seconds; end

  # Returns the value of attribute options.
  def options; end

  # Returns the value of attribute period.
  def period; end

  def round_time(time); end
  def time_range; end

  # Returns the value of attribute time_zone.
  def time_zone; end

  # Returns the value of attribute week_start.
  def week_start; end

  private

  # @return [Boolean]
  def entire_series?(series_default); end

  def generate_series(data, multiple_groups, group_index); end
  def handle_multiple(data, series, multiple_groups, group_index); end
  def key_format; end
  def now; end
  def step; end
  def utc; end
end

Groupdate::VERSION = T.let(T.unsafe(nil), String)
