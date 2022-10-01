# This is an autogenerated file for dynamic methods in GradeDistribution
# Please rerun bundle exec rake rails_rbi:models[GradeDistribution] to regenerate.

# typed: strong
module GradeDistribution::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module GradeDistribution::GeneratedAttributeMethods
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

  sig { returns(Float) }
  def percent_a; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_a=(value); end

  sig { returns(T::Boolean) }
  def percent_a?; end

  sig { returns(Float) }
  def percent_a_minus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_a_minus=(value); end

  sig { returns(T::Boolean) }
  def percent_a_minus?; end

  sig { returns(Float) }
  def percent_a_plus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_a_plus=(value); end

  sig { returns(T::Boolean) }
  def percent_a_plus?; end

  sig { returns(Float) }
  def percent_b; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_b=(value); end

  sig { returns(T::Boolean) }
  def percent_b?; end

  sig { returns(Float) }
  def percent_b_minus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_b_minus=(value); end

  sig { returns(T::Boolean) }
  def percent_b_minus?; end

  sig { returns(Float) }
  def percent_b_plus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_b_plus=(value); end

  sig { returns(T::Boolean) }
  def percent_b_plus?; end

  sig { returns(Float) }
  def percent_c; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_c=(value); end

  sig { returns(T::Boolean) }
  def percent_c?; end

  sig { returns(Float) }
  def percent_c_minus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_c_minus=(value); end

  sig { returns(T::Boolean) }
  def percent_c_minus?; end

  sig { returns(Float) }
  def percent_c_plus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_c_plus=(value); end

  sig { returns(T::Boolean) }
  def percent_c_plus?; end

  sig { returns(Float) }
  def percent_d; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_d=(value); end

  sig { returns(T::Boolean) }
  def percent_d?; end

  sig { returns(Float) }
  def percent_d_minus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_d_minus=(value); end

  sig { returns(T::Boolean) }
  def percent_d_minus?; end

  sig { returns(Float) }
  def percent_d_plus; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_d_plus=(value); end

  sig { returns(T::Boolean) }
  def percent_d_plus?; end

  sig { returns(Float) }
  def percent_f; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def percent_f=(value); end

  sig { returns(T::Boolean) }
  def percent_f?; end

  sig { returns(T.nilable(Integer)) }
  def section_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def section_id=(value); end

  sig { returns(T::Boolean) }
  def section_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module GradeDistribution::GeneratedAssociationMethods
  sig { returns(::Section) }
  def section; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Section).void)).returns(::Section) }
  def build_section(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Section).void)).returns(::Section) }
  def create_section(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Section).void)).returns(::Section) }
  def create_section!(*args, &block); end

  sig { params(value: ::Section).void }
  def section=(value); end

  sig { returns(::Section) }
  def reload_section; end
end

module GradeDistribution::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[GradeDistribution]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[GradeDistribution]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[GradeDistribution]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(GradeDistribution)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(GradeDistribution) }
  def find_by_id!(id); end
end

class GradeDistribution < ApplicationRecord
  include GradeDistribution::GeneratedAttributeMethods
  include GradeDistribution::GeneratedAssociationMethods
  extend GradeDistribution::CustomFinderMethods
  extend GradeDistribution::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(GradeDistribution::ActiveRecord_Relation, GradeDistribution::ActiveRecord_Associations_CollectionProxy, GradeDistribution::ActiveRecord_AssociationRelation) }

  sig { params(num: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(GradeDistribution::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

module GradeDistribution::QueryMethodsReturningRelation
  sig { returns(GradeDistribution::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(GradeDistribution::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: GradeDistribution).returns(T::Boolean)).returns(T::Array[GradeDistribution]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(GradeDistribution::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(GradeDistribution::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(GradeDistribution::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(GradeDistribution::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: GradeDistribution::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module GradeDistribution::QueryMethodsReturningAssociationRelation
  sig { returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(GradeDistribution::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: GradeDistribution).returns(T::Boolean)).returns(T::Array[GradeDistribution]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: GradeDistribution::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class GradeDistribution::ActiveRecord_Relation < ActiveRecord::Relation
  include GradeDistribution::ActiveRelation_WhereNot
  include GradeDistribution::CustomFinderMethods
  include GradeDistribution::QueryMethodsReturningRelation
  Elem = type_member {{fixed: GradeDistribution}}

  sig { params(num: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(GradeDistribution::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class GradeDistribution::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include GradeDistribution::ActiveRelation_WhereNot
  include GradeDistribution::CustomFinderMethods
  include GradeDistribution::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: GradeDistribution}}

  sig { params(num: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class GradeDistribution::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include GradeDistribution::CustomFinderMethods
  include GradeDistribution::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: GradeDistribution}}

  sig { params(records: T.any(GradeDistribution, T::Array[GradeDistribution])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(GradeDistribution, T::Array[GradeDistribution])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(GradeDistribution, T::Array[GradeDistribution])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(GradeDistribution, T::Array[GradeDistribution])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(GradeDistribution::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end