# This is an autogenerated file for dynamic methods in Searchjoy::Search
# Please rerun bundle exec rake rails_rbi:models[Searchjoy::Search] to regenerate.

# typed: strong
module Searchjoy::Search::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Searchjoy::Search::GeneratedAttributeMethods
  sig { returns(T.nilable(Integer)) }
  def convertable_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def convertable_id=(value); end

  sig { returns(T::Boolean) }
  def convertable_id?; end

  sig { returns(T.nilable(String)) }
  def convertable_type; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def convertable_type=(value); end

  sig { returns(T::Boolean) }
  def convertable_type?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def converted_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def converted_at=(value); end

  sig { returns(T::Boolean) }
  def converted_at?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def created_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
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
  def normalized_query; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def normalized_query=(value); end

  sig { returns(T::Boolean) }
  def normalized_query?; end

  sig { returns(T.nilable(String)) }
  def query; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def query=(value); end

  sig { returns(T::Boolean) }
  def query?; end

  sig { returns(T.nilable(Integer)) }
  def results_count; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def results_count=(value); end

  sig { returns(T::Boolean) }
  def results_count?; end

  sig { returns(T.nilable(String)) }
  def search_type; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def search_type=(value); end

  sig { returns(T::Boolean) }
  def search_type?; end

  sig { returns(T.nilable(Integer)) }
  def user_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def user_id=(value); end

  sig { returns(T::Boolean) }
  def user_id?; end
end

module Searchjoy::Search::GeneratedAssociationMethods
  sig { returns(::Searchjoy::Conversion::ActiveRecord_Associations_CollectionProxy) }
  def conversions; end

  sig { returns(T::Array[T.untyped]) }
  def conversion_ids; end

  sig { params(value: T::Enumerable[::Searchjoy::Conversion]).void }
  def conversions=(value); end

  sig { returns(T.untyped) }
  def convertable; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def build_convertable(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def create_convertable(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: T.untyped).void)).returns(T.untyped) }
  def create_convertable!(*args, &block); end

  sig { params(value: T.untyped).void }
  def convertable=(value); end

  sig { returns(T.untyped) }
  def reload_convertable; end

  sig { returns(T.nilable(::User)) }
  def user; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user!(*args, &block); end

  sig { params(value: T.nilable(::User)).void }
  def user=(value); end

  sig { returns(T.nilable(::User)) }
  def reload_user; end
end

module Searchjoy::Search::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Searchjoy::Search]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Searchjoy::Search]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Searchjoy::Search]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Searchjoy::Search)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Searchjoy::Search) }
  def find_by_id!(id); end
end

class Searchjoy::Search < ActiveRecord::Base
  include Searchjoy::Search::GeneratedAttributeMethods
  include Searchjoy::Search::GeneratedAssociationMethods
  extend Searchjoy::Search::CustomFinderMethods
  extend Searchjoy::Search::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Searchjoy::Search::ActiveRecord_Relation, Searchjoy::Search::ActiveRecord_Associations_CollectionProxy, Searchjoy::Search::ActiveRecord_AssociationRelation) }

  sig { params(num: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

module Searchjoy::Search::QueryMethodsReturningRelation
  sig { returns(Searchjoy::Search::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Searchjoy::Search).returns(T::Boolean)).returns(T::Array[Searchjoy::Search]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Searchjoy::Search::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Searchjoy::Search::QueryMethodsReturningAssociationRelation
  sig { returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Searchjoy::Search).returns(T::Boolean)).returns(T::Array[Searchjoy::Search]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Searchjoy::Search::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class Searchjoy::Search::ActiveRecord_Relation < ActiveRecord::Relation
  include Searchjoy::Search::ActiveRelation_WhereNot
  include Searchjoy::Search::CustomFinderMethods
  include Searchjoy::Search::QueryMethodsReturningRelation
  Elem = type_member {{fixed: Searchjoy::Search}}

  sig { params(num: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Searchjoy::Search::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Searchjoy::Search::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Searchjoy::Search::ActiveRelation_WhereNot
  include Searchjoy::Search::CustomFinderMethods
  include Searchjoy::Search::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Searchjoy::Search}}

  sig { params(num: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Searchjoy::Search::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Searchjoy::Search::CustomFinderMethods
  include Searchjoy::Search::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Searchjoy::Search}}

  sig { params(records: T.any(Searchjoy::Search, T::Array[Searchjoy::Search])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Searchjoy::Search, T::Array[Searchjoy::Search])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Searchjoy::Search, T::Array[Searchjoy::Search])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Searchjoy::Search, T::Array[Searchjoy::Search])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Searchjoy::Search::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end
