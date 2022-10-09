# This is an autogenerated file for dynamic methods in SubjectArea
# Please rerun bundle exec rake rails_rbi:models[SubjectArea] to regenerate.

# typed: strong
module SubjectArea::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module SubjectArea::GeneratedAttributeMethods
  sig { returns(String) }
  def code; end

  sig { params(value: T.any(String, Symbol)).void }
  def code=(value); end

  sig { returns(T::Boolean) }
  def code?; end

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

  sig { returns(String) }
  def name; end

  sig { params(value: T.any(String, Symbol)).void }
  def name=(value); end

  sig { returns(T::Boolean) }
  def name?; end

  sig { returns(T.nilable(Integer)) }
  def superseding_subject_area_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def superseding_subject_area_id=(value); end

  sig { returns(T::Boolean) }
  def superseding_subject_area_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module SubjectArea::GeneratedAssociationMethods
  sig { returns(::Course::ActiveRecord_Associations_CollectionProxy) }
  def courses; end

  sig { returns(T::Array[Integer]) }
  def course_ids; end

  sig { params(value: T::Enumerable[::Course]).void }
  def courses=(value); end

  sig { returns(T.nilable(::SubjectArea)) }
  def preceding_subject_area; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def build_preceding_subject_area(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def create_preceding_subject_area(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def create_preceding_subject_area!(*args, &block); end

  sig { params(value: T.nilable(::SubjectArea)).void }
  def preceding_subject_area=(value); end

  sig { returns(T.nilable(::SubjectArea)) }
  def reload_preceding_subject_area; end

  sig { returns(T.nilable(::SubjectArea)) }
  def superseding_subject_area; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def build_superseding_subject_area(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def create_superseding_subject_area(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::SubjectArea).void)).returns(::SubjectArea) }
  def create_superseding_subject_area!(*args, &block); end

  sig { params(value: T.nilable(::SubjectArea)).void }
  def superseding_subject_area=(value); end

  sig { returns(T.nilable(::SubjectArea)) }
  def reload_superseding_subject_area; end

  sig { returns(::Term::ActiveRecord_Associations_CollectionProxy) }
  def terms; end

  sig { returns(T::Array[Integer]) }
  def term_ids; end

  sig { params(value: T::Enumerable[::Term]).void }
  def terms=(value); end
end

module SubjectArea::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[SubjectArea]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[SubjectArea]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[SubjectArea]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(SubjectArea)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(SubjectArea) }
  def find_by_id!(id); end
end

class SubjectArea < ApplicationRecord
  include SubjectArea::GeneratedAttributeMethods
  include SubjectArea::GeneratedAssociationMethods
  extend SubjectArea::CustomFinderMethods
  extend SubjectArea::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(SubjectArea::ActiveRecord_Relation, SubjectArea::ActiveRecord_Associations_CollectionProxy, SubjectArea::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def self.active(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def self.order_by_name(*args); end

  sig { params(num: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(SubjectArea::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

class SubjectArea::ActiveRecord_Relation < ActiveRecord::Relation
  include SubjectArea::ActiveRelation_WhereNot
  include SubjectArea::CustomFinderMethods
  include SubjectArea::QueryMethodsReturningRelation
  Elem = type_member {{fixed: SubjectArea}}

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def active(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def order_by_name(*args); end

  sig { params(num: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(SubjectArea::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class SubjectArea::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include SubjectArea::ActiveRelation_WhereNot
  include SubjectArea::CustomFinderMethods
  include SubjectArea::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: SubjectArea}}

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def active(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def order_by_name(*args); end

  sig { params(num: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class SubjectArea::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include SubjectArea::CustomFinderMethods
  include SubjectArea::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: SubjectArea}}

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def active(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def order_by_name(*args); end

  sig { params(records: T.any(SubjectArea, T::Array[SubjectArea])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(SubjectArea, T::Array[SubjectArea])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(SubjectArea, T::Array[SubjectArea])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(SubjectArea, T::Array[SubjectArea])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

module SubjectArea::QueryMethodsReturningRelation
  sig { returns(SubjectArea::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(SubjectArea::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: SubjectArea).returns(T::Boolean)).returns(T::Array[SubjectArea]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(SubjectArea::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(SubjectArea::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(SubjectArea::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(SubjectArea::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: SubjectArea::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module SubjectArea::QueryMethodsReturningAssociationRelation
  sig { returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(SubjectArea::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: SubjectArea).returns(T::Boolean)).returns(T::Array[SubjectArea]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(SubjectArea::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: SubjectArea::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end