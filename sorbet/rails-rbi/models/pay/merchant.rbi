# This is an autogenerated file for dynamic methods in Pay::Merchant
# Please rerun bundle exec rake rails_rbi:models[Pay::Merchant] to regenerate.

# typed: strong
module Pay::Merchant::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Pay::Merchant::GeneratedAttributeMethods
  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T.nilable(T.any(T::Array[T.untyped], T::Boolean, Float, T::Hash[T.untyped, T.untyped], Integer, String))) }
  def data; end

  sig { params(value: T.nilable(T.any(T::Array[T.untyped], T::Boolean, Float, T::Hash[T.untyped, T.untyped], Integer, String))).void }
  def data=(value); end

  sig { returns(T::Boolean) }
  def data?; end

  sig { returns(T.nilable(T::Boolean)) }
  def default; end

  sig { params(value: T.nilable(T::Boolean)).void }
  def default=(value); end

  sig { returns(T::Boolean) }
  def default?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(Integer)) }
  def owner_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def owner_id=(value); end

  sig { returns(T::Boolean) }
  def owner_id?; end

  sig { returns(T.nilable(String)) }
  def owner_type; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def owner_type=(value); end

  sig { returns(T::Boolean) }
  def owner_type?; end

  sig { returns(String) }
  def processor; end

  sig { params(value: T.any(String, Symbol)).void }
  def processor=(value); end

  sig { returns(T::Boolean) }
  def processor?; end

  sig { returns(T.nilable(String)) }
  def processor_id; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def processor_id=(value); end

  sig { returns(T::Boolean) }
  def processor_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module Pay::Merchant::GeneratedAssociationMethods
  sig { returns(T.untyped) }
  def owner; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def build_owner(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def create_owner(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def create_owner!(*args, &block); end

  sig { params(value: T.untyped).void }
  def owner=(value); end

  sig { returns(T.untyped) }
  def reload_owner; end
end

module Pay::Merchant::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Pay::Merchant]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Pay::Merchant]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Pay::Merchant]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Pay::Merchant)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Pay::Merchant) }
  def find_by_id!(id); end
end

class Pay::Merchant < Pay::ApplicationRecord
  include Pay::Merchant::GeneratedAttributeMethods
  include Pay::Merchant::GeneratedAssociationMethods
  extend Pay::Merchant::CustomFinderMethods
  extend Pay::Merchant::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Pay::Merchant::ActiveRecord_Relation, Pay::Merchant::ActiveRecord_Associations_CollectionProxy, Pay::Merchant::ActiveRecord_AssociationRelation) }

  sig { params(num: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Pay::Merchant::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

module Pay::Merchant::QueryMethodsReturningRelation
  sig { returns(Pay::Merchant::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Pay::Merchant).returns(T::Boolean)).returns(T::Array[Pay::Merchant]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Pay::Merchant::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Pay::Merchant::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Pay::Merchant::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Pay::Merchant::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Pay::Merchant::QueryMethodsReturningAssociationRelation
  sig { returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Pay::Merchant).returns(T::Boolean)).returns(T::Array[Pay::Merchant]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Pay::Merchant::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class Pay::Merchant::ActiveRecord_Relation < ActiveRecord::Relation
  include Pay::Merchant::ActiveRelation_WhereNot
  include Pay::Merchant::CustomFinderMethods
  include Pay::Merchant::QueryMethodsReturningRelation
  Elem = type_member {{fixed: Pay::Merchant}}

  sig { params(num: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Pay::Merchant::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Pay::Merchant::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Pay::Merchant::ActiveRelation_WhereNot
  include Pay::Merchant::CustomFinderMethods
  include Pay::Merchant::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Pay::Merchant}}

  sig { params(num: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Pay::Merchant::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Pay::Merchant::CustomFinderMethods
  include Pay::Merchant::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Pay::Merchant}}

  sig { params(records: T.any(Pay::Merchant, T::Array[Pay::Merchant])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Pay::Merchant, T::Array[Pay::Merchant])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Pay::Merchant, T::Array[Pay::Merchant])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Pay::Merchant, T::Array[Pay::Merchant])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Pay::Merchant::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end