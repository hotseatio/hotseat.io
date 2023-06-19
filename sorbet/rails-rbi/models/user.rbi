# This is an autogenerated file for dynamic methods in User
# Please rerun bundle exec rake rails_rbi:models[User] to regenerate.

# typed: strong
module User::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module User::GeneratedAttributeMethods
  sig { returns(T::Boolean) }
  def admin; end

  sig { params(value: T::Boolean).void }
  def admin=(value); end

  sig { returns(T::Boolean) }
  def admin?; end

  sig { returns(T::Boolean) }
  def beta_tester; end

  sig { params(value: T::Boolean).void }
  def beta_tester=(value); end

  sig { returns(T::Boolean) }
  def beta_tester?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def current_sign_in_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def current_sign_in_at=(value); end

  sig { returns(T::Boolean) }
  def current_sign_in_at?; end

  sig { returns(T.untyped) }
  def current_sign_in_ip; end

  sig { params(value: T.untyped).void }
  def current_sign_in_ip=(value); end

  sig { returns(T::Boolean) }
  def current_sign_in_ip?; end

  sig { returns(String) }
  def email; end

  sig { params(value: T.any(String, Symbol)).void }
  def email=(value); end

  sig { returns(T::Boolean) }
  def email?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def last_sign_in_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def last_sign_in_at=(value); end

  sig { returns(T::Boolean) }
  def last_sign_in_at?; end

  sig { returns(T.untyped) }
  def last_sign_in_ip; end

  sig { params(value: T.untyped).void }
  def last_sign_in_ip=(value); end

  sig { returns(T::Boolean) }
  def last_sign_in_ip?; end

  sig { returns(String) }
  def name; end

  sig { params(value: T.any(String, Symbol)).void }
  def name=(value); end

  sig { returns(T::Boolean) }
  def name?; end

  sig { returns(Integer) }
  def notification_token_count; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def notification_token_count=(value); end

  sig { returns(T::Boolean) }
  def notification_token_count?; end

  sig { returns(T.nilable(String)) }
  def phone; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def phone=(value); end

  sig { returns(T::Boolean) }
  def phone?; end

  sig { returns(T.nilable(String)) }
  def phone_verification_otp_secret; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def phone_verification_otp_secret=(value); end

  sig { returns(T::Boolean) }
  def phone_verification_otp_secret?; end

  sig { returns(T.nilable(String)) }
  def provider; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def provider=(value); end

  sig { returns(T::Boolean) }
  def provider?; end

  sig { returns(String) }
  def referral_code; end

  sig { params(value: T.any(String, Symbol)).void }
  def referral_code=(value); end

  sig { returns(T::Boolean) }
  def referral_code?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def referral_completed_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def referral_completed_at=(value); end

  sig { returns(T::Boolean) }
  def referral_completed_at?; end

  sig { returns(T.nilable(Integer)) }
  def referred_by_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def referred_by_id=(value); end

  sig { returns(T::Boolean) }
  def referred_by_id?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def remember_created_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def remember_created_at=(value); end

  sig { returns(T::Boolean) }
  def remember_created_at?; end

  sig { returns(T.nilable(String)) }
  def remember_token; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def remember_token=(value); end

  sig { returns(T::Boolean) }
  def remember_token?; end

  sig { returns(Integer) }
  def sign_in_count; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def sign_in_count=(value); end

  sig { returns(T::Boolean) }
  def sign_in_count?; end

  sig { returns(T.nilable(String)) }
  def uid; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def uid=(value); end

  sig { returns(T::Boolean) }
  def uid?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module User::GeneratedAssociationMethods
  sig { returns(::Pay::Charge::ActiveRecord_Associations_CollectionProxy) }
  def charges; end

  sig { returns(T::Array[Integer]) }
  def charge_ids; end

  sig { params(value: T::Enumerable[::Pay::Charge]).void }
  def charges=(value); end

  sig { returns(::Course::ActiveRecord_Associations_CollectionProxy) }
  def courses; end

  sig { returns(T::Array[Integer]) }
  def course_ids; end

  sig { params(value: T::Enumerable[::Course]).void }
  def courses=(value); end

  sig { returns(::Mailkick::Subscription::ActiveRecord_Associations_CollectionProxy) }
  def mailkick_subscriptions; end

  sig { returns(T::Array[T.untyped]) }
  def mailkick_subscription_ids; end

  sig { params(value: T::Enumerable[::Mailkick::Subscription]).void }
  def mailkick_subscriptions=(value); end

  sig { returns(::Notification::ActiveRecord_Associations_CollectionProxy) }
  def notifications; end

  sig { returns(T::Array[Integer]) }
  def notification_ids; end

  sig { params(value: T::Enumerable[::Notification]).void }
  def notifications=(value); end

  sig { returns(::Pay::Customer::ActiveRecord_Associations_CollectionProxy) }
  def pay_customers; end

  sig { returns(T::Array[Integer]) }
  def pay_customer_ids; end

  sig { params(value: T::Enumerable[::Pay::Customer]).void }
  def pay_customers=(value); end

  sig { returns(T.nilable(::Pay::Customer)) }
  def payment_processor; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Pay::Customer).void)).returns(::Pay::Customer) }
  def build_payment_processor(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Pay::Customer).void)).returns(::Pay::Customer) }
  def create_payment_processor(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Pay::Customer).void)).returns(::Pay::Customer) }
  def create_payment_processor!(*args, &block); end

  sig { params(value: T.nilable(::Pay::Customer)).void }
  def payment_processor=(value); end

  sig { returns(T.nilable(::Pay::Customer)) }
  def reload_payment_processor; end

  sig { returns(T.nilable(::User)) }
  def referred_by; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_referred_by(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_referred_by(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_referred_by!(*args, &block); end

  sig { params(value: T.nilable(::User)).void }
  def referred_by=(value); end

  sig { returns(T.nilable(::User)) }
  def reload_referred_by; end

  sig { returns(::User::ActiveRecord_Associations_CollectionProxy) }
  def referred_users; end

  sig { returns(T::Array[Integer]) }
  def referred_user_ids; end

  sig { params(value: T::Enumerable[::User]).void }
  def referred_users=(value); end

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

  sig { returns(::Section::ActiveRecord_Associations_CollectionProxy) }
  def sections; end

  sig { returns(T::Array[Integer]) }
  def section_ids; end

  sig { params(value: T::Enumerable[::Section]).void }
  def sections=(value); end

  sig { returns(::Pay::Subscription::ActiveRecord_Associations_CollectionProxy) }
  def subscriptions; end

  sig { returns(T::Array[Integer]) }
  def subscription_ids; end

  sig { params(value: T::Enumerable[::Pay::Subscription]).void }
  def subscriptions=(value); end

  sig { returns(::WebpushDevice::ActiveRecord_Associations_CollectionProxy) }
  def webpush_devices; end

  sig { returns(T::Array[Integer]) }
  def webpush_device_ids; end

  sig { params(value: T::Enumerable[::WebpushDevice]).void }
  def webpush_devices=(value); end
end

module User::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[User]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[User]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[User]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(User)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(User) }
  def find_by_id!(id); end
end

class User < ApplicationRecord
  include User::GeneratedAttributeMethods
  include User::GeneratedAssociationMethods
  extend User::CustomFinderMethods
  extend User::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(User::ActiveRecord_Relation, User::ActiveRecord_Associations_CollectionProxy, User::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def self.subscribed(*args); end

  sig { params(num: T.nilable(Integer)).returns(User::ActiveRecord_Relation) }
  def self.page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(User::ActiveRecord_Relation) }
  def self.per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(User::ActiveRecord_Relation) }
  def self.padding(num); end

  sig { returns(Integer) }
  def self.default_per_page; end
end

class User::ActiveRecord_Relation < ActiveRecord::Relation
  include User::ActiveRelation_WhereNot
  include User::CustomFinderMethods
  include User::QueryMethodsReturningRelation
  Elem = type_member {{fixed: User}}

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def subscribed(*args); end

  sig { params(num: T.nilable(Integer)).returns(User::ActiveRecord_Relation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(User::ActiveRecord_Relation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(User::ActiveRecord_Relation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class User::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include User::ActiveRelation_WhereNot
  include User::CustomFinderMethods
  include User::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: User}}

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def subscribed(*args); end

  sig { params(num: T.nilable(Integer)).returns(User::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(User::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(User::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

class User::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include User::CustomFinderMethods
  include User::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: User}}

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def subscribed(*args); end

  sig { params(records: T.any(User, T::Array[User])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(User, T::Array[User])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(User, T::Array[User])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(User, T::Array[User])).returns(T.self_type) }
  def concat(*records); end

  sig { params(num: T.nilable(Integer)).returns(User::ActiveRecord_AssociationRelation) }
  def page(num = nil); end

  sig { params(num: Integer, max_per_page: T.nilable(Integer)).returns(User::ActiveRecord_AssociationRelation) }
  def per(num, max_per_page = nil); end

  sig { params(num: Integer).returns(User::ActiveRecord_AssociationRelation) }
  def padding(num); end

  sig { returns(T::Boolean) }
  def last_page?; end
end

module User::QueryMethodsReturningRelation
  sig { returns(User::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(User::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: User).returns(T::Boolean)).returns(T::Array[User]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(User::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(User::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(User::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: User::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module User::QueryMethodsReturningAssociationRelation
  sig { returns(User::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(User::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(User::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: User).returns(T::Boolean)).returns(T::Array[User]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(User::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(User::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(User::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: User::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end
