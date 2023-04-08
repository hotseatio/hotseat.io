# This is an autogenerated file for dynamic methods in WebpushDevice
# Please rerun bundle exec rake rails_rbi:models[WebpushDevice] to regenerate.

# typed: strong
module WebpushDevice::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module WebpushDevice::GeneratedAttributeMethods
  sig { returns(String) }
  def auth_key; end

  sig { params(value: T.any(String, Symbol)).void }
  def auth_key=(value); end

  sig { returns(T::Boolean) }
  def auth_key?; end

  sig { returns(String) }
  def browser; end

  sig { params(value: T.any(String, Symbol)).void }
  def browser=(value); end

  sig { returns(T::Boolean) }
  def browser?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(String)) }
  def nickname; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def nickname=(value); end

  sig { returns(T::Boolean) }
  def nickname?; end

  sig { returns(String) }
  def notification_endpoint; end

  sig { params(value: T.any(String, Symbol)).void }
  def notification_endpoint=(value); end

  sig { returns(T::Boolean) }
  def notification_endpoint?; end

  sig { returns(String) }
  def operating_system; end

  sig { params(value: T.any(String, Symbol)).void }
  def operating_system=(value); end

  sig { returns(T::Boolean) }
  def operating_system?; end

  sig { returns(String) }
  def p256dh_key; end

  sig { params(value: T.any(String, Symbol)).void }
  def p256dh_key=(value); end

  sig { returns(T::Boolean) }
  def p256dh_key?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end

  sig { returns(T.nilable(Integer)) }
  def user_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def user_id=(value); end

  sig { returns(T::Boolean) }
  def user_id?; end

  sig { returns(String) }
  def version; end

  sig { params(value: T.any(String, Symbol)).void }
  def version=(value); end

  sig { returns(T::Boolean) }
  def version?; end
end

module WebpushDevice::GeneratedAssociationMethods
  sig { returns(::User) }
  def user; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user!(*args, &block); end

  sig { params(value: ::User).void }
  def user=(value); end

  sig { returns(::User) }
  def reload_user; end
end

module WebpushDevice::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[WebpushDevice]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[WebpushDevice]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[WebpushDevice]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(WebpushDevice)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(WebpushDevice) }
  def find_by_id!(id); end
end

class WebpushDevice < ApplicationRecord
  include WebpushDevice::GeneratedAttributeMethods
  include WebpushDevice::GeneratedAssociationMethods
  extend WebpushDevice::CustomFinderMethods
  extend WebpushDevice::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(WebpushDevice::ActiveRecord_Relation, WebpushDevice::ActiveRecord_Associations_CollectionProxy, WebpushDevice::ActiveRecord_AssociationRelation) }

  sig { params(num: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(WebpushDevice::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

module WebpushDevice::QueryMethodsReturningRelation
  sig { returns(WebpushDevice::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(WebpushDevice::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: WebpushDevice).returns(T::Boolean)).returns(T::Array[WebpushDevice]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(WebpushDevice::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(WebpushDevice::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(WebpushDevice::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(WebpushDevice::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: WebpushDevice::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module WebpushDevice::QueryMethodsReturningAssociationRelation
  sig { returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(WebpushDevice::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: WebpushDevice).returns(T::Boolean)).returns(T::Array[WebpushDevice]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: WebpushDevice::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class WebpushDevice::ActiveRecord_Relation < ActiveRecord::Relation
  include WebpushDevice::ActiveRelation_WhereNot
  include WebpushDevice::CustomFinderMethods
  include WebpushDevice::QueryMethodsReturningRelation
  Elem = type_member {{fixed: WebpushDevice}}

  sig { params(num: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(WebpushDevice::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class WebpushDevice::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include WebpushDevice::ActiveRelation_WhereNot
  include WebpushDevice::CustomFinderMethods
  include WebpushDevice::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: WebpushDevice}}

  sig { params(num: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class WebpushDevice::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include WebpushDevice::CustomFinderMethods
  include WebpushDevice::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: WebpushDevice}}

  sig { params(records: T.any(WebpushDevice, T::Array[WebpushDevice])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(WebpushDevice, T::Array[WebpushDevice])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(WebpushDevice, T::Array[WebpushDevice])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(WebpushDevice, T::Array[WebpushDevice])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(WebpushDevice::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end
