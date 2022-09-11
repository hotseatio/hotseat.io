# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `propshaft` gem.
# Please instead update this file by running `bin/tapioca gem propshaft`.

module Propshaft
  def logger; end
  def logger=(val); end

  class << self
    def logger; end
    def logger=(val); end
  end
end

class Propshaft::Assembly
  # @return [Assembly] a new instance of Assembly
  def initialize(config); end

  def compilers; end

  # Returns the value of attribute config.
  def config; end

  def load_path; end
  def processor; end
  def resolver; end
  def reveal(path_type = T.unsafe(nil)); end
  def server; end

  private

  def manifest_path; end
end

class Propshaft::Asset
  # @return [Asset] a new instance of Asset
  def initialize(path, logical_path:, version: T.unsafe(nil)); end

  def ==(other_asset); end
  def content; end
  def content_type; end
  def digest; end
  def digested_path; end

  # @return [Boolean]
  def fresh?(digest); end

  def length; end

  # Returns the value of attribute logical_path.
  def logical_path; end

  # Returns the value of attribute path.
  def path; end

  # Returns the value of attribute version.
  def version; end

  private

  # @return [Boolean]
  def already_digested?; end
end

class Propshaft::Compilers
  # @return [Compilers] a new instance of Compilers
  def initialize(assembly); end

  # @return [Boolean]
  def any?; end

  # Returns the value of attribute assembly.
  def assembly; end

  # @return [Boolean]
  def compilable?(asset); end

  def compile(asset); end
  def register(mime_type, klass); end

  # Returns the value of attribute registrations.
  def registrations; end
end

class Propshaft::Compilers::CssAssetUrls
  # @return [CssAssetUrls] a new instance of CssAssetUrls
  def initialize(assembly); end

  # Returns the value of attribute assembly.
  def assembly; end

  def compile(logical_path, input); end

  private

  def asset_url(resolved_path, logical_path, pattern); end
  def resolve_path(directory, filename); end
end

Propshaft::Compilers::CssAssetUrls::ASSET_URL_PATTERN = T.let(T.unsafe(nil), Regexp)

class Propshaft::Compilers::SourceMappingUrls
  # @return [SourceMappingUrls] a new instance of SourceMappingUrls
  def initialize(assembly); end

  # Returns the value of attribute assembly.
  def assembly; end

  def compile(logical_path, input); end

  private

  def asset_path(source_mapping_url, logical_path); end
  def source_mapping_url(resolved_path, comment); end
end

Propshaft::Compilers::SourceMappingUrls::SOURCE_MAPPING_PATTERN = T.let(T.unsafe(nil), Regexp)

# Generic base class for all Propshaft exceptions.
class Propshaft::Error < ::StandardError; end

module Propshaft::Helper
  def compute_asset_path(path, options = T.unsafe(nil)); end
end

class Propshaft::LoadPath
  # @return [LoadPath] a new instance of LoadPath
  def initialize(paths = T.unsafe(nil), version: T.unsafe(nil)); end

  def assets(content_types: T.unsafe(nil)); end

  # Returns a ActiveSupport::FileUpdateChecker object configured to clear the cache of the load_path
  # when the directories passed during its initialization have changes. This is used in development
  # and test to ensure the map caches are reset when javascript files are changed.
  def cache_sweeper; end

  def find(asset_name); end
  def manifest; end

  # Returns the value of attribute paths.
  def paths; end

  # Returns the value of attribute version.
  def version; end

  private

  def all_files_from_tree(path); end
  def assets_by_path; end
  def clear_cache; end
  def dedup(paths); end
  def without_dotfiles(files); end
end

# Raised when LoadPath cannot find the requested asset
class Propshaft::MissingAssetError < ::Propshaft::Error
  # @return [MissingAssetError] a new instance of MissingAssetError
  def initialize(path); end

  def message; end
end

class Propshaft::OutputPath
  # @return [OutputPath] a new instance of OutputPath
  def initialize(path, manifest); end

  def clean(count, age); end
  def files; end

  # Returns the value of attribute manifest.
  def manifest; end

  # Returns the value of attribute path.
  def path; end

  private

  def all_files_from_tree(path); end
  def extract_path_and_digest(digested_path); end
  def fresh_version_within_limit(mtime, count, expires_at:, limit:); end
  def remove(path); end
end

class Propshaft::Processor
  # @return [Processor] a new instance of Processor
  def initialize(load_path:, output_path:, compilers:); end

  def clean; end
  def clobber; end

  # Returns the value of attribute compilers.
  def compilers; end

  # Returns the value of attribute load_path.
  def load_path; end

  # Returns the value of attribute output_path.
  def output_path; end

  def process; end

  private

  def compile_asset(asset); end
  def copy_asset(asset); end
  def ensure_output_path_exists; end
  def output_asset(asset); end
  def output_assets; end
  def write_manifest; end
end

Propshaft::Processor::MANIFEST_FILENAME = T.let(T.unsafe(nil), String)
class Propshaft::Railtie < ::Rails::Railtie; end
module Propshaft::Resolver; end

class Propshaft::Resolver::Dynamic
  # @return [Dynamic] a new instance of Dynamic
  def initialize(load_path:, prefix:); end

  # Returns the value of attribute load_path.
  def load_path; end

  # Returns the value of attribute prefix.
  def prefix; end

  def read(logical_path); end
  def resolve(logical_path); end
end

class Propshaft::Resolver::Static
  # @return [Static] a new instance of Static
  def initialize(manifest_path:, prefix:); end

  # Returns the value of attribute manifest_path.
  def manifest_path; end

  # Returns the value of attribute prefix.
  def prefix; end

  def read(logical_path); end
  def resolve(logical_path); end

  private

  def parsed_manifest; end
end

class Propshaft::Server
  # @return [Server] a new instance of Server
  def initialize(assembly); end

  def call(env); end
  def inspect; end

  private

  def extract_path_and_digest(env); end
end
