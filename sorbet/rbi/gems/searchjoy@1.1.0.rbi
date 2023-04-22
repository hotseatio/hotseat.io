# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `searchjoy` gem.
# Please instead update this file by running `bin/tapioca gem searchjoy`.

# source://searchjoy//lib/searchjoy/track.rb#1
module Searchjoy
  # source://searchjoy//lib/searchjoy.rb#22
  def conversion_name; end

  # source://searchjoy//lib/searchjoy.rb#22
  def conversion_name=(val); end

  # source://searchjoy//lib/searchjoy.rb#27
  def multiple_conversions; end

  # source://searchjoy//lib/searchjoy.rb#27
  def multiple_conversions=(val); end

  # source://searchjoy//lib/searchjoy.rb#23
  def query_name; end

  # source://searchjoy//lib/searchjoy.rb#23
  def query_name=(val); end

  # source://searchjoy//lib/searchjoy.rb#24
  def query_url; end

  # source://searchjoy//lib/searchjoy.rb#24
  def query_url=(val); end

  # source://searchjoy//lib/searchjoy.rb#12
  def time_zone; end

  # source://searchjoy//lib/searchjoy.rb#18
  def top_searches; end

  # source://searchjoy//lib/searchjoy.rb#18
  def top_searches=(val); end

  class << self
    # source://searchjoy//lib/searchjoy.rb#30
    def attach_to_searchkick!; end

    # source://searchjoy//lib/searchjoy.rb#36
    def backfill_conversions; end

    # source://searchjoy//lib/searchjoy.rb#22
    def conversion_name; end

    # source://searchjoy//lib/searchjoy.rb#22
    def conversion_name=(val); end

    # source://searchjoy//lib/searchjoy.rb#27
    def multiple_conversions; end

    # source://searchjoy//lib/searchjoy.rb#27
    def multiple_conversions=(val); end

    # source://searchjoy//lib/searchjoy.rb#23
    def query_name; end

    # source://searchjoy//lib/searchjoy.rb#23
    def query_name=(val); end

    # source://searchjoy//lib/searchjoy.rb#24
    def query_url; end

    # source://searchjoy//lib/searchjoy.rb#24
    def query_url=(val); end

    # source://railties/7.0.4.3/lib/rails/engine.rb#405
    def railtie_helpers_paths; end

    # source://railties/7.0.4.3/lib/rails/engine.rb#394
    def railtie_namespace; end

    # source://railties/7.0.4.3/lib/rails/engine.rb#409
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end

    # source://railties/7.0.4.3/lib/rails/engine.rb#397
    def table_name_prefix; end

    # source://searchjoy//lib/searchjoy.rb#12
    def time_zone; end

    # source://searchjoy//lib/searchjoy.rb#13
    def time_zone=(time_zone); end

    # source://searchjoy//lib/searchjoy.rb#18
    def top_searches; end

    # source://searchjoy//lib/searchjoy.rb#18
    def top_searches=(val); end

    # source://railties/7.0.4.3/lib/rails/engine.rb#401
    def use_relative_model_naming?; end
  end
end

class Searchjoy::Conversion < ::ActiveRecord::Base
  include ::Searchjoy::Conversion::GeneratedAttributeMethods
  include ::Searchjoy::Conversion::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_convertable(*args); end

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_search(*args); end

  class << self
    # source://activesupport/7.0.4.3/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://activerecord/7.0.4.3/lib/active_record/reflection.rb#11
    def _reflections; end

    # source://activemodel/7.0.4.3/lib/active_model/validations.rb#52
    def _validators; end

    # source://activerecord/7.0.4.3/lib/active_record/enum.rb#116
    def defined_enums; end

    # source://kaminari-activerecord/1.2.2/lib/kaminari/activerecord/active_record_model_extension.rb#15
    def page(num = T.unsafe(nil)); end
  end
end

module Searchjoy::Conversion::GeneratedAssociationMethods
  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#28
  def build_search(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#103
  def convertable; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#111
  def convertable=(value); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#132
  def convertable_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#136
  def convertable_previously_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#32
  def create_search(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#36
  def create_search!(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#19
  def reload_convertable; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#19
  def reload_search; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#103
  def search; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#111
  def search=(value); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#132
  def search_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#136
  def search_previously_changed?; end
end

module Searchjoy::Conversion::GeneratedAttributeMethods; end

# source://searchjoy//lib/searchjoy/engine.rb#2
class Searchjoy::Engine < ::Rails::Engine
  class << self
    # source://activesupport/7.0.4.3/lib/active_support/callbacks.rb#68
    def __callbacks; end
  end
end

class Searchjoy::Search < ::ActiveRecord::Base
  include ::Searchjoy::Search::GeneratedAttributeMethods
  include ::Searchjoy::Search::GeneratedAssociationMethods
  include ::Kaminari::ActiveRecordModelExtension
  include ::Kaminari::ConfigurationMethods
  extend ::Kaminari::ConfigurationMethods::ClassMethods

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_conversions(*args); end

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_convertable(*args); end

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def autosave_associated_records_for_user(*args); end

  def convert(convertable = T.unsafe(nil)); end
  def converted?; end

  # source://activerecord/7.0.4.3/lib/active_record/autosave_association.rb#160
  def validate_associated_records_for_conversions(*args); end

  protected

  def set_normalized_query; end

  class << self
    # source://activesupport/7.0.4.3/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://activerecord/7.0.4.3/lib/active_record/reflection.rb#11
    def _reflections; end

    # source://activemodel/7.0.4.3/lib/active_model/validations.rb#52
    def _validators; end

    # source://activerecord/7.0.4.3/lib/active_record/enum.rb#116
    def defined_enums; end

    # source://kaminari-activerecord/1.2.2/lib/kaminari/activerecord/active_record_model_extension.rb#15
    def page(num = T.unsafe(nil)); end
  end
end

module Searchjoy::Search::GeneratedAssociationMethods
  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#28
  def build_user(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/collection_association.rb#62
  def conversion_ids; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/collection_association.rb#72
  def conversion_ids=(ids); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#103
  def conversions; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#111
  def conversions=(value); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#103
  def convertable; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#111
  def convertable=(value); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#132
  def convertable_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#136
  def convertable_previously_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#32
  def create_user(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#36
  def create_user!(*args, &block); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#19
  def reload_convertable; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/singular_association.rb#19
  def reload_user; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#103
  def user; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/association.rb#111
  def user=(value); end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#132
  def user_changed?; end

  # source://activerecord/7.0.4.3/lib/active_record/associations/builder/belongs_to.rb#136
  def user_previously_changed?; end
end

module Searchjoy::Search::GeneratedAttributeMethods; end

class Searchjoy::SearchesController < ::ActionController::Base
  def index; end
  def overview; end
  def recent; end
  def stream; end

  protected

  def set_search_type; end
  def set_search_types; end
  def set_searches; end
  def set_time_range; end
  def set_time_zone; end

  private

  # source://actionview/7.0.4.3/lib/action_view/layouts.rb#328
  def _layout(lookup_context, formats); end

  def _layout_from_proc; end

  class << self
    # source://activesupport/7.0.4.3/lib/active_support/callbacks.rb#68
    def __callbacks; end

    # source://actionview/7.0.4.3/lib/action_view/layouts.rb#209
    def _layout; end

    # source://actionview/7.0.4.3/lib/action_view/layouts.rb#210
    def _layout_conditions; end

    # source://actionpack/7.0.4.3/lib/action_controller/metal.rb#210
    def middleware_stack; end
  end
end

# source://searchjoy//lib/searchjoy/track.rb#2
module Searchjoy::Track; end

# source://searchjoy//lib/searchjoy/track.rb#36
module Searchjoy::Track::MultiSearch
  # source://searchjoy//lib/searchjoy/track.rb#37
  def perform; end
end

# source://searchjoy//lib/searchjoy/track.rb#3
module Searchjoy::Track::Query
  # source://searchjoy//lib/searchjoy/track.rb#25
  def execute; end

  # source://searchjoy//lib/searchjoy/track.rb#31
  def search; end

  # source://searchjoy//lib/searchjoy/track.rb#4
  def track; end
end

# source://searchjoy//lib/searchjoy/version.rb#2
Searchjoy::VERSION = T.let(T.unsafe(nil), String)
