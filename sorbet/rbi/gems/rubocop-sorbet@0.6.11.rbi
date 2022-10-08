# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rubocop-sorbet` gem.
# Please instead update this file by running `bin/tapioca gem rubocop-sorbet`.

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet/version.rb:2
module RuboCop; end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:6
module RuboCop::Cop; end

# @deprecated IgnoredPattern class has been replaced with AllowedPattern.
#
# source://rubocop-1.32.0/lib/rubocop/cop/mixin/allowed_pattern.rb:38
RuboCop::Cop::IgnoredPattern = RuboCop::Cop::AllowedPattern

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:7
module RuboCop::Cop::Sorbet; end

# This cop disallows using `.override(allow_incompatible: true)`.
# Using `allow_incompatible` suggests a violation of the Liskov
# Substitution Principle, meaning that a subclass is not a valid
# subtype of it's superclass. This Cop prevents these design smells
# from occurring.
#
# @example
#
#   # bad
#   sig.override(allow_incompatible: true)
#
#   # good
#   sig.override
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:21
class RuboCop::Cop::Sorbet::AllowIncompatibleOverride < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:35
  def allow_incompatible?(param0); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:39
  def allow_incompatible_override?(param0 = T.unsafe(nil)); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:31
  def not_nil?(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:48
  def on_send(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/allow_incompatible_override.rb:22
  def sig?(param0); end
end

# This cop disallows binding the return value of `T.any`, `T.all`, `T.enum`
# to a constant directly. To bind the value, one must use `T.type_alias`.
#
# @example
#
#   # bad
#   FooOrBar = T.any(Foo, Bar)
#
#   # good
#   FooOrBar = T.type_alias { T.any(Foo, Bar) }
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:18
class RuboCop::Cop::Sorbet::BindingConstantWithoutTypeAlias < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:116
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:19
  def binding_unaliased_type?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:51
  def dynamic_type_creation_with_block?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:66
  def generic_parameter_decl_block_call?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:60
  def generic_parameter_decl_call?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:72
  def method_needing_aliasing_on_t?(param0); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:85
  def not_dynamic_type_creation_with_block?(node); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:89
  def not_generic_parameter_decl?(node); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:93
  def not_nil?(node); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:81
  def not_t_let?(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:97
  def on_casgn(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:41
  def t_let?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:32
  def using_deprecated_type_alias_syntax?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/binding_constants_without_type_alias.rb:23
  def using_type_alias?(param0 = T.unsafe(nil)); end
end

# This cop ensures that callback conditionals are bound to the right type
# so that they are type checked properly.
#
# Auto-correction is unsafe because other libraries define similar style callbacks as Rails, but don't always need
# binding to the attached class. Auto-correcting those usages can lead to false positives and auto-correction
# introduces new typing errors.
#
# @example
#
#   # bad
#   class Post < ApplicationRecord
#   before_create :do_it, if: -> { should_do_it? }
#
#   def should_do_it?
#   true
#   end
#   end
#
#   # good
#   class Post < ApplicationRecord
#   before_create :do_it, if: -> {
#   T.bind(self, Post)
#   should_do_it?
#   }
#
#   def should_do_it?
#   true
#   end
#   end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/callback_conditionals_binding.rb:35
class RuboCop::Cop::Sorbet::CallbackConditionalsBinding < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/callback_conditionals_binding.rb:47
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/callback_conditionals_binding.rb:99
  def on_send(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/callback_conditionals_binding.rb:36
RuboCop::Cop::Sorbet::CallbackConditionalsBinding::CALLBACKS = T.let(T.unsafe(nil), Array)

# This cop disallows the usage of `checked(true)`. This usage could cause
# confusion; it could lead some people to believe that a method would be checked
# even if runtime checks have not been enabled on the class or globally.
# Additionally, in the event where checks are enabled, `checked(true)` would
# be redundant; only `checked(false)` or `soft` would change the behaviour.
#
# @example
#
#   # bad
#   sig { void.checked(true) }
#
#   # good
#   sig { void }
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/checked_true_in_signature.rb:22
class RuboCop::Cop::Sorbet::CheckedTrueInSignature < ::RuboCop::Cop::Sorbet::SignatureCop
  include ::RuboCop::Cop::RangeHelp

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/checked_true_in_signature.rb:25
  def offending_node(param0); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/checked_true_in_signature.rb:36
  def on_signature(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/checked_true_in_signature.rb:29
RuboCop::Cop::Sorbet::CheckedTrueInSignature::MESSAGE = T.let(T.unsafe(nil), String)

# This cop disallows the calls that are used to get constants fom Strings
# such as +constantize+, +const_get+, and +constants+.
#
# The goal of this cop is to make the code easier to statically analyze,
# more IDE-friendly, and more predictable. It leads to code that clearly
# expresses which values the constant can have.
#
# @example
#
#   # bad
#   class_name.constantize
#
#   # bad
#   constants.detect { |c| c.name == "User" }
#
#   # bad
#   const_get(class_name)
#
#   # good
#   case class_name
#   when "User"
#   User
#   else
#   raise ArgumentError
#   end
#
#   # good
#   { "User" => User }.fetch(class_name)
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/constants_from_strings.rb:36
class RuboCop::Cop::Sorbet::ConstantsFromStrings < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/constants_from_strings.rb:37
  def constant_from_string?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/constants_from_strings.rb:41
  def on_send(node); end
end

# This cop checks that the Sorbet sigil comes as the first magic comment in the file.
#
# The expected order for magic comments is: typed, (en)?coding, warn_indent then frozen_string_literal.
#
# For example, the following bad ordering:
#
# ```ruby
# class Foo; end
# ```
#
# Will be corrected as:
#
# ```ruby
# class Foo; end
# ```
#
# Only `typed`, `(en)?coding`, `warn_indent` and `frozen_string_literal` magic comments are considered,
# other comments or magic comments are left in the same place.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:30
class RuboCop::Cop::Sorbet::EnforceSigilOrder < ::RuboCop::Cop::Sorbet::ValidSigil
  include ::RuboCop::Cop::RangeHelp

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:42
  def autocorrect(_node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:33
  def investigate(processed_source); end

  protected

  # checks
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:91
  def check_magic_comments_order(tokens); end

  # Get all the tokens in `processed_source` that match `MAGIC_REGEX`
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:83
  def extract_magic_comments(processed_source); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:67
RuboCop::Cop::Sorbet::EnforceSigilOrder::CODING_REGEX = T.let(T.unsafe(nil), Regexp)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:69
RuboCop::Cop::Sorbet::EnforceSigilOrder::FROZEN_REGEX = T.let(T.unsafe(nil), Regexp)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:68
RuboCop::Cop::Sorbet::EnforceSigilOrder::INDENT_REGEX = T.let(T.unsafe(nil), Regexp)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:78
RuboCop::Cop::Sorbet::EnforceSigilOrder::MAGIC_REGEX = T.let(T.unsafe(nil), Regexp)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_sigil_order.rb:71
RuboCop::Cop::Sorbet::EnforceSigilOrder::PREFERRED_ORDER = T.let(T.unsafe(nil), Hash)

# This cop checks that every method definition and attribute accessor has a Sorbet signature.
#
# It also suggest an autocorrect with placeholders so the following code:
#
# ```
# def foo(a, b, c); end
# ```
#
# Will be corrected as:
#
# ```
# sig { params(a: T.untyped, b: T.untyped, c: T.untyped).returns(T.untyped)
# def foo(a, b, c); end
# ```
#
# You can configure the placeholders used by changing the following options:
#
# * `ParameterTypePlaceholder`: placeholders used for parameter types (default: 'T.untyped')
# * `ReturnTypePlaceholder`: placeholders used for return types (default: 'T.untyped')
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:29
class RuboCop::Cop::Sorbet::EnforceSignatures < ::RuboCop::Cop::Sorbet::SignatureCop
  # @return [EnforceSignatures] a new instance of EnforceSignatures
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:30
  def initialize(config = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:35
  def accessor?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:55
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:39
  def on_def(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:43
  def on_defs(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:47
  def on_send(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:51
  def on_signature(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:74
  def scope(node); end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:82
  def check_node(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:93
  def param_type_placeholder; end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:97
  def return_type_placeholder; end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:101
class RuboCop::Cop::Sorbet::EnforceSignatures::SigSuggestion
  # @return [SigSuggestion] a new instance of SigSuggestion
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:104
  def initialize(indent, param_placeholder, return_placeholder); end

  # Returns the value of attribute params.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:102
  def params; end

  # Sets the attribute params
  #
  # @param value the value to set the attribute params to.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:102
  def params=(_arg0); end

  # Returns the value of attribute returns.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:102
  def returns; end

  # Sets the attribute returns
  #
  # @param value the value to set the attribute returns to.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:102
  def returns=(_arg0); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:112
  def to_autocorrect; end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:124
  def generate_params; end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/enforce_signatures.rb:135
  def generate_return; end
end

# This cop checks that there is only one Sorbet sigil in a given file
#
# For example, the following class with two sigils
#
# ```ruby
# class Foo; end
# ```
#
# Will be corrected as:
#
# ```ruby
# class Foo; end
# ```
#
# Other comments or magic comments are left in place.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_single_sigil.rb:26
class RuboCop::Cop::Sorbet::EnforceSingleSigil < ::RuboCop::Cop::Sorbet::ValidSigil
  include ::RuboCop::Cop::RangeHelp

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_single_sigil.rb:39
  def autocorrect(_node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_single_sigil.rb:29
  def investigate(processed_source); end

  protected

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/enforce_single_sigil.rb:55
  def extract_all_sigils(processed_source); end
end

# This cop makes the Sorbet `false` sigil mandatory in all files.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/false_sigil.rb:10
class RuboCop::Cop::Sorbet::FalseSigil < ::RuboCop::Cop::Sorbet::HasSigil
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/false_sigil.rb:11
  def minimum_strictness; end
end

# This cop ensures RBI shims do not include a call to extend T::Sig
# or to extend T::Helpers
#
# @example
#
#   # bad
#   module SomeModule
#   extend T::Sig
#   extend T::Helpers
#
#   sig { returns(String) }
#   def foo; end
#   end
#
#   # good
#   module SomeModule
#   sig { returns(String) }
#   def foo; end
#   end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:25
class RuboCop::Cop::Sorbet::ForbidExtendTSigHelpersInShims < ::RuboCop::Cop::Cop
  include ::RuboCop::Cop::RangeHelp

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:39
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:35
  def extend_t_helpers?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:31
  def extend_t_sig?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:47
  def on_send(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:28
RuboCop::Cop::Sorbet::ForbidExtendTSigHelpersInShims::MSG = T.let(T.unsafe(nil), String)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_extend_t_sig_helpers_in_shims.rb:29
RuboCop::Cop::Sorbet::ForbidExtendTSigHelpersInShims::RESTRICT_ON_SEND = T.let(T.unsafe(nil), Array)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:29
class RuboCop::Cop::Sorbet::ForbidIncludeConstLiteral < ::RuboCop::Cop::Cop
  # @return [ForbidIncludeConstLiteral] a new instance of ForbidIncludeConstLiteral
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:40
  def initialize(*_arg0); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:56
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:34
  def not_lit_const_include?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:45
  def on_send(node); end

  # Returns the value of attribute used_names.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:32
  def used_names; end

  # Sets the attribute used_names
  #
  # @param value the value to set the attribute used_names to.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:32
  def used_names=(_arg0); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_include_const_literal.rb:30
RuboCop::Cop::Sorbet::ForbidIncludeConstLiteral::MSG = T.let(T.unsafe(nil), String)

# This cop makes sure that RBI files are always located under the defined allowed paths.
#
# Options:
#
# * `AllowedPaths`: A list of the paths where RBI files are allowed (default: ["sorbet/rbi/**"])
#
# @example
#   # bad
#   # lib/some_file.rbi
#   # other_file.rbi
#
#   # good
#   # sorbet/rbi/some_file.rbi
#   # sorbet/rbi/any/path/for/file.rbi
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_rbi_outside_of_allowed_paths.rb:22
class RuboCop::Cop::Sorbet::ForbidRBIOutsideOfAllowedPaths < ::RuboCop::Cop::Cop
  include ::RuboCop::Cop::RangeHelp

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_rbi_outside_of_allowed_paths.rb:25
  def investigate(processed_source); end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/forbid_rbi_outside_of_allowed_paths.rb:57
  def allowed_paths; end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_superclass_const_literal.rb:27
class RuboCop::Cop::Sorbet::ForbidSuperclassConstLiteral < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_superclass_const_literal.rb:30
  def not_lit_const_superclass?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_superclass_const_literal.rb:38
  def on_class(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_superclass_const_literal.rb:28
RuboCop::Cop::Sorbet::ForbidSuperclassConstLiteral::MSG = T.let(T.unsafe(nil), String)

# This cop disallows using `T.unsafe` anywhere.
#
# @example
#
#   # bad
#   T.unsafe(foo)
#
#   # good
#   foo
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_unsafe.rb:17
class RuboCop::Cop::Sorbet::ForbidTUnsafe < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_unsafe.rb:20
  def on_send(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_unsafe.rb:18
  def t_unsafe?(param0 = T.unsafe(nil)); end
end

# This cop disallows using `T.untyped` anywhere.
#
# @example
#
#   # bad
#   sig { params(my_argument: T.untyped).void }
#   def foo(my_argument); end
#
#   # good
#   sig { params(my_argument: String).void }
#   def foo(my_argument); end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_untyped.rb:20
class RuboCop::Cop::Sorbet::ForbidTUntyped < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_untyped.rb:23
  def on_send(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_t_untyped.rb:21
  def t_untyped?(param0 = T.unsafe(nil)); end
end

# This cop disallows use of `T.untyped` or `T.nilable(T.untyped)`
# as a prop type for `T::Struct`.
#
# @example
#
#   # bad
#   class SomeClass
#   const :foo, T.untyped
#   prop :bar, T.nilable(T.untyped)
#   end
#
#   # good
#   class SomeClass
#   const :foo, Integer
#   prop :bar, T.nilable(String)
#   end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:25
class RuboCop::Cop::Sorbet::ForbidUntypedStructProps < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:48
  def on_class(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:40
  def subclass_of_t_struct?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:36
  def t_nilable_untyped(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:28
  def t_struct(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:32
  def t_untyped(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:44
  def untyped_props(param0); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/forbid_untyped_struct_props.rb:26
RuboCop::Cop::Sorbet::ForbidUntypedStructProps::MSG = T.let(T.unsafe(nil), String)

# This cop makes the Sorbet typed sigil mandatory in all files.
#
# Options:
#
# * `SuggestedStrictness`: Sorbet strictness level suggested in offense messages (default: 'false')
# * `MinimumStrictness`: If set, make offense if the strictness level in the file is below this one
#
# If a `MinimumStrictness` level is specified, it will be used in offense messages and autocorrect.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/has_sigil.rb:17
class RuboCop::Cop::Sorbet::HasSigil < ::RuboCop::Cop::Sorbet::ValidSigil
  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/has_sigil.rb:20
  def require_sigil_on_all_files?; end
end

# This cop makes the Sorbet `ignore` sigil mandatory in all files.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/ignore_sigil.rb:10
class RuboCop::Cop::Sorbet::IgnoreSigil < ::RuboCop::Cop::Sorbet::HasSigil
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/ignore_sigil.rb:11
  def minimum_strictness; end
end

# This cop checks for the ordering of keyword arguments required by
# sorbet-runtime. The ordering requires that all keyword arguments
# are at the end of the parameters list, and all keyword arguments
# with a default value must be after those without default values.
#
# @example
#
#   # bad
#   sig { params(a: Integer, b: String).void }
#   def foo(a: 1, b:); end
#
#   # good
#   sig { params(b: String, a: Integer).void }
#   def foo(b:, a: 1); end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/keyword_argument_ordering.rb:23
class RuboCop::Cop::Sorbet::KeywordArgumentOrdering < ::RuboCop::Cop::Sorbet::SignatureCop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/keyword_argument_ordering.rb:24
  def on_signature(node); end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/keyword_argument_ordering.rb:34
  def check_order_for_kwoptargs(parameters); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/mutable_constant_sorbet_aware_behaviour.rb:8
module RuboCop::Cop::Sorbet::MutableConstantSorbetAwareBehaviour
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/mutable_constant_sorbet_aware_behaviour.rb:15
  def on_assignment(value); end

  class << self
    # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/mutable_constant_sorbet_aware_behaviour.rb:9
    def prepended(base); end
  end
end

# This cop ensures one ancestor per requires_ancestor line
# rather than chaining them as a comma-separated list.
#
# @example
#
#   # bad
#   module SomeModule
#   requires_ancestor Kernel, Minitest::Assertions
#   end
#
#   # good
#   module SomeModule
#   requires_ancestor Kernel
#   requires_ancestor Minitest::Assertions
#   end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:24
class RuboCop::Cop::Sorbet::OneAncestorPerLine < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:35
  def abstract?(param0); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:51
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:31
  def more_than_one_ancestor(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:45
  def on_class(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:39
  def on_module(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:27
  def requires_ancestors(param0); end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:67
  def new_ra_line(indent_count); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:61
  def process_node(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/one_ancestor_per_line.rb:25
RuboCop::Cop::Sorbet::OneAncestorPerLine::MSG = T.let(T.unsafe(nil), String)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:15
class RuboCop::Cop::Sorbet::SignatureBuildOrder < ::RuboCop::Cop::Sorbet::SignatureCop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:54
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:34
  def on_signature(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:30
  def root_call(param0); end

  private

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:96
  def call_chain(sig_child_node); end

  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:92
  def can_autocorrect?; end

  # This method exists to reparse the current node with modern features enabled.
  # Modern features include "index send" emitting, which is necessary to unparse
  # "index sends" (i.e. `[]` calls) back to index accessors (i.e. as `foo[bar]``).
  # Otherwise, we would get the unparsed node as `foo.[](bar)`.
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:83
  def node_reparsed_with_modern_features(node); end
end

# Create a subclass of AST Builder that has modern features turned on
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:72
class RuboCop::Cop::Sorbet::SignatureBuildOrder::ModernBuilder < ::RuboCop::AST::Builder; end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_build_order.rb:16
RuboCop::Cop::Sorbet::SignatureBuildOrder::ORDER = T.let(T.unsafe(nil), Hash)

# Abstract cop specific to Sorbet signatures
#
# You can subclass it to use the `on_signature` trigger and the `signature?` node matcher.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:11
class RuboCop::Cop::Sorbet::SignatureCop < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:26
  def allowed_recv(recv); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:33
  def on_block(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:37
  def on_signature(_); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:14
  def signature?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:18
  def with_runtime?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/signatures/signature_cop.rb:22
  def without_runtime?(param0 = T.unsafe(nil)); end
end

# This cop ensures empty class/module definitions in RBI files are
# done on a single line rather than being split across multiple lines.
#
# @example
#
#   # bad
#   module SomeModule
#   end
#
#   # good
#   module SomeModule; end
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:17
class RuboCop::Cop::Sorbet::SingleLineRbiClassModuleDefinitions < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:28
  def autocorrect(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:24
  def on_class(node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:20
  def on_module(node); end

  protected

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:34
  def convert_newlines(source); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:38
  def process_node(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/rbi/single_line_rbi_class_module_definitions.rb:18
RuboCop::Cop::Sorbet::SingleLineRbiClassModuleDefinitions::MSG = T.let(T.unsafe(nil), String)

# This cop makes the Sorbet `strict` sigil mandatory in all files.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/strict_sigil.rb:10
class RuboCop::Cop::Sorbet::StrictSigil < ::RuboCop::Cop::Sorbet::HasSigil
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/strict_sigil.rb:11
  def minimum_strictness; end
end

# This cop makes the Sorbet `strong` sigil mandatory in all files.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/strong_sigil.rb:10
class RuboCop::Cop::Sorbet::StrongSigil < ::RuboCop::Cop::Sorbet::HasSigil
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/strong_sigil.rb:11
  def minimum_strictness; end
end

# This cop makes the Sorbet `true` sigil mandatory in all files.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/true_sigil.rb:10
class RuboCop::Cop::Sorbet::TrueSigil < ::RuboCop::Cop::Sorbet::HasSigil
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/true_sigil.rb:11
  def minimum_strictness; end
end

# This cop ensures all constants used as `T.type_alias` are using CamelCase.
#
# @example
#
#   # bad
#   FOO_OR_BAR = T.type_alias { T.any(Foo, Bar) }
#
#   # good
#   FooOrBar = T.type_alias { T.any(Foo, Bar) }
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/type_alias_name.rb:17
class RuboCop::Cop::Sorbet::TypeAliasName < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/type_alias_name.rb:20
  def casgn_type_alias?(param0 = T.unsafe(nil)); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/type_alias_name.rb:32
  def on_casgn(node); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/type_alias_name.rb:18
RuboCop::Cop::Sorbet::TypeAliasName::MSG = T.let(T.unsafe(nil), String)

# This cop checks that every Ruby file contains a valid Sorbet sigil.
# Adapted from: https://gist.github.com/clarkdave/85aca4e16f33fd52aceb6a0a29936e52
#
# Options:
#
# * `RequireSigilOnAllFiles`: make offense if the Sorbet typed is not found in the file (default: false)
# * `SuggestedStrictness`: Sorbet strictness level suggested in offense messages (default: 'false')
# * `MinimumStrictness`: If set, make offense if the strictness level in the file is below this one
#
# If a `MinimumStrictness` level is specified, it will be used in offense messages and autocorrect.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:18
class RuboCop::Cop::Sorbet::ValidSigil < ::RuboCop::Cop::Cop
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:33
  def autocorrect(_node); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:21
  def investigate(processed_source); end

  protected

  # checks
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:68
  def check_sigil_present(sigil); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:125
  def check_strictness_level(sigil, strictness); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:103
  def check_strictness_not_empty(sigil, strictness); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:114
  def check_strictness_valid(sigil, strictness); end

  # extraction
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:56
  def extract_sigil(processed_source); end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:62
  def extract_strictness(sigil); end

  # Default is `nil`
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:155
  def minimum_strictness; end

  # Default is `false`
  #
  # @return [Boolean]
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:144
  def require_sigil_on_all_files?; end

  # Default is `'false'`
  #
  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:149
  def suggested_strictness; end

  # source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:84
  def suggested_strictness_level(minimum_strictness, suggested_strictness); end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:52
RuboCop::Cop::Sorbet::ValidSigil::SIGIL_REGEX = T.let(T.unsafe(nil), Regexp)

# source://rubocop-sorbet-0.6.11/lib/rubocop/cop/sorbet/sigils/valid_sigil.rb:51
RuboCop::Cop::Sorbet::ValidSigil::STRICTNESS_LEVELS = T.let(T.unsafe(nil), Array)

class RuboCop::Cop::Style::MutableConstant < ::RuboCop::Cop::Base
  include ::RuboCop::Cop::Sorbet::MutableConstantSorbetAwareBehaviour
end

# source://rubocop-1.32.0/lib/rubocop/ast_aliases.rb:5
RuboCop::NodePattern = RuboCop::AST::NodePattern

# source://rubocop-1.32.0/lib/rubocop/ast_aliases.rb:6
RuboCop::ProcessedSource = RuboCop::AST::ProcessedSource

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet/version.rb:3
module RuboCop::Sorbet; end

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet.rb:11
RuboCop::Sorbet::CONFIG = T.let(T.unsafe(nil), Hash)

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet.rb:10
RuboCop::Sorbet::CONFIG_DEFAULT = T.let(T.unsafe(nil), Pathname)

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet.rb:7
class RuboCop::Sorbet::Error < ::StandardError; end

# Because RuboCop doesn't yet support plugins, we have to monkey patch in a
# bit of our configuration.
#
# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet/inject.rb:9
module RuboCop::Sorbet::Inject
  class << self
    # source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet/inject.rb:10
    def defaults!; end
  end
end

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet.rb:9
RuboCop::Sorbet::PROJECT_ROOT = T.let(T.unsafe(nil), Pathname)

# source://rubocop-sorbet-0.6.11/lib/rubocop/sorbet/version.rb:4
RuboCop::Sorbet::VERSION = T.let(T.unsafe(nil), String)

# source://rubocop-1.32.0/lib/rubocop/ast_aliases.rb:7
RuboCop::Token = RuboCop::AST::Token
