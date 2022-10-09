# This is an autogenerated file for dynamic methods in Section
# Please rerun bundle exec rake rails_rbi:models[Section] to regenerate.

# typed: strong
module Section::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Section::GeneratedAttributeMethods
  sig { returns(T.nilable(String)) }
  def asucla_id; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def asucla_id=(value); end

  sig { returns(T::Boolean) }
  def asucla_id?; end

  sig { returns(Integer) }
  def course_id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def course_id=(value); end

  sig { returns(T::Boolean) }
  def course_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T::Array[String]) }
  def days; end

  sig { params(value: T::Array[T.any(String, Symbol)]).void }
  def days=(value); end

  sig { returns(T::Boolean) }
  def days?; end

  sig { returns(Integer) }
  def enrollment_capacity; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def enrollment_capacity=(value); end

  sig { returns(T::Boolean) }
  def enrollment_capacity?; end

  sig { returns(Integer) }
  def enrollment_count; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def enrollment_count=(value); end

  sig { returns(T::Boolean) }
  def enrollment_count?; end

  sig { returns(String) }
  def enrollment_status; end

  sig { params(value: T.any(String, Symbol)).void }
  def enrollment_status=(value); end

  sig { returns(T::Boolean) }
  def enrollment_status?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def final_end; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def final_end=(value); end

  sig { returns(T::Boolean) }
  def final_end?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def final_start; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def final_start=(value); end

  sig { returns(T::Boolean) }
  def final_start?; end

  sig { returns(T.untyped) }
  def format; end

  sig { params(value: T.untyped).void }
  def format=(value); end

  sig { returns(T::Boolean) }
  def format?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(Integer)) }
  def index; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def index=(value); end

  sig { returns(T::Boolean) }
  def index?; end

  sig { returns(T.nilable(Integer)) }
  def instructor_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def instructor_id=(value); end

  sig { returns(T::Boolean) }
  def instructor_id?; end

  sig { returns(T::Array[String]) }
  def locations; end

  sig { params(value: T::Array[T.any(String, Symbol)]).void }
  def locations=(value); end

  sig { returns(T::Boolean) }
  def locations?; end

  sig { returns(String) }
  def registrar_id; end

  sig { params(value: T.any(String, Symbol)).void }
  def registrar_id=(value); end

  sig { returns(T::Boolean) }
  def registrar_id?; end

  sig { returns(T::Array[String]) }
  def registrar_instructors; end

  sig { params(value: T::Array[T.any(String, Symbol)]).void }
  def registrar_instructors=(value); end

  sig { returns(T::Boolean) }
  def registrar_instructors?; end

  sig { returns(T::Boolean) }
  def should_update_instructor; end

  sig { params(value: T::Boolean).void }
  def should_update_instructor=(value); end

  sig { returns(T::Boolean) }
  def should_update_instructor?; end

  sig { returns(T.nilable(Integer)) }
  def summer_duration_weeks; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def summer_duration_weeks=(value); end

  sig { returns(T::Boolean) }
  def summer_duration_weeks?; end

  sig { returns(T.untyped) }
  def summer_session; end

  sig { params(value: T.untyped).void }
  def summer_session=(value); end

  sig { returns(T::Boolean) }
  def summer_session?; end

  sig { returns(Integer) }
  def term_id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def term_id=(value); end

  sig { returns(T::Boolean) }
  def term_id?; end

  sig { returns(T::Array[String]) }
  def times; end

  sig { params(value: T::Array[T.any(String, Symbol)]).void }
  def times=(value); end

  sig { returns(T::Boolean) }
  def times?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end

  sig { returns(Integer) }
  def waitlist_capacity; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def waitlist_capacity=(value); end

  sig { returns(T::Boolean) }
  def waitlist_capacity?; end

  sig { returns(Integer) }
  def waitlist_count; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def waitlist_count=(value); end

  sig { returns(T::Boolean) }
  def waitlist_count?; end

  sig { returns(String) }
  def waitlist_status; end

  sig { params(value: T.any(String, Symbol)).void }
  def waitlist_status=(value); end

  sig { returns(T::Boolean) }
  def waitlist_status?; end

  sig { returns(T.nilable(String)) }
  def website; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def website=(value); end

  sig { returns(T::Boolean) }
  def website?; end
end

module Section::GeneratedAssociationMethods
  sig { returns(::Course) }
  def course; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Course).void)).returns(::Course) }
  def build_course(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Course).void)).returns(::Course) }
  def create_course(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Course).void)).returns(::Course) }
  def create_course!(*args, &block); end

  sig { params(value: ::Course).void }
  def course=(value); end

  sig { returns(::Course) }
  def reload_course; end

  sig { returns(::EnrollmentDatum::ActiveRecord_Associations_CollectionProxy) }
  def enrollment_data; end

  sig { returns(T::Array[Integer]) }
  def enrollment_datum_ids; end

  sig { params(value: T::Enumerable[::EnrollmentDatum]).void }
  def enrollment_data=(value); end

  sig { returns(T.nilable(::GradeDistribution)) }
  def grade_distribution; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::GradeDistribution).void)).returns(::GradeDistribution) }
  def build_grade_distribution(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::GradeDistribution).void)).returns(::GradeDistribution) }
  def create_grade_distribution(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::GradeDistribution).void)).returns(::GradeDistribution) }
  def create_grade_distribution!(*args, &block); end

  sig { params(value: T.nilable(::GradeDistribution)).void }
  def grade_distribution=(value); end

  sig { returns(T.nilable(::GradeDistribution)) }
  def reload_grade_distribution; end

  sig { returns(T.nilable(::Instructor)) }
  def instructor; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Instructor).void)).returns(::Instructor) }
  def build_instructor(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Instructor).void)).returns(::Instructor) }
  def create_instructor(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Instructor).void)).returns(::Instructor) }
  def create_instructor!(*args, &block); end

  sig { params(value: T.nilable(::Instructor)).void }
  def instructor=(value); end

  sig { returns(T.nilable(::Instructor)) }
  def reload_instructor; end

  sig { returns(::Relationship::ActiveRecord_Associations_CollectionProxy) }
  def relationships; end

  sig { returns(T::Array[Integer]) }
  def relationship_ids; end

  sig { params(value: T::Enumerable[::Relationship]).void }
  def relationships=(value); end

  sig { returns(::Review::ActiveRecord_Associations_CollectionProxy) }
  def reviews; end

  sig { returns(T::Array[Integer]) }
  def review_ids; end

  sig { params(value: T::Enumerable[::Review]).void }
  def reviews=(value); end

  sig { returns(::Term) }
  def term; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Term).void)).returns(::Term) }
  def build_term(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Term).void)).returns(::Term) }
  def create_term(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Term).void)).returns(::Term) }
  def create_term!(*args, &block); end

  sig { params(value: ::Term).void }
  def term=(value); end

  sig { returns(::Term) }
  def reload_term; end

  sig { returns(::Textbook::ActiveRecord_Associations_CollectionProxy) }
  def textbooks; end

  sig { returns(T::Array[Integer]) }
  def textbook_ids; end

  sig { params(value: T::Enumerable[::Textbook]).void }
  def textbooks=(value); end
end

module Section::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Section]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Section]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Section]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Section)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Section) }
  def find_by_id!(id); end
end

class Section < ApplicationRecord
  include Section::GeneratedAttributeMethods
  include Section::GeneratedAssociationMethods
  extend Section::CustomFinderMethods
  extend Section::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Section::ActiveRecord_Relation, Section::ActiveRecord_Associations_CollectionProxy, Section::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def self.order_by_course(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def self.order_by_index(*args); end

  sig { params(num: T.nilable(Integer)).returns(Section::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Section::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Section::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

class Section::ActiveRecord_Relation < ActiveRecord::Relation
  include Section::ActiveRelation_WhereNot
  include Section::CustomFinderMethods
  include Section::QueryMethodsReturningRelation
  Elem = type_member {{fixed: Section}}

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def order_by_course(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def order_by_index(*args); end

  sig { params(num: T.nilable(Integer)).returns(Section::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Section::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Section::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Section::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Section::ActiveRelation_WhereNot
  include Section::CustomFinderMethods
  include Section::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Section}}

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def order_by_course(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def order_by_index(*args); end

  sig { params(num: T.nilable(Integer)).returns(Section::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Section::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Section::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class Section::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Section::CustomFinderMethods
  include Section::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Section}}

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def order_by_course(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def order_by_index(*args); end

  sig { params(records: T.any(Section, T::Array[Section])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Section, T::Array[Section])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Section, T::Array[Section])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Section, T::Array[Section])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(Section::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(Section::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(Section::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

module Section::QueryMethodsReturningRelation
  sig { returns(Section::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Section::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Section).returns(T::Boolean)).returns(T::Array[Section]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Section::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Section::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Section::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Section::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Section::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Section::QueryMethodsReturningAssociationRelation
  sig { returns(Section::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Section::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Section::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Section).returns(T::Boolean)).returns(T::Array[Section]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Section::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Section::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Section::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Section::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Section::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end