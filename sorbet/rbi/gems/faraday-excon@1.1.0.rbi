# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `faraday-excon` gem.
# Please instead update this file by running `bin/tapioca gem faraday-excon`.

# This is the main namespace for Faraday.
#
# It provides methods to create {Connection} objects, and HTTP-related
# methods to use directly.
#
# @example Helpful class methods for easy usage
#   Faraday.get "http://faraday.com"
# @example Helpful class method `.new` to create {Connection} objects.
#   conn = Faraday.new "http://faraday.com"
#   conn.get '/'
#
# source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:3
module Faraday
  class << self
    # @overload default_adapter
    # @overload default_adapter=
    #
    # source://faraday-1.10.0/lib/faraday.rb:81
    def default_adapter; end

    # Documented elsewhere, see default_adapter reader
    #
    # source://faraday-1.10.0/lib/faraday.rb:137
    def default_adapter=(adapter); end

    # @overload default_connection
    # @overload default_connection=
    #
    # source://faraday-1.10.0/lib/faraday.rb:155
    def default_connection; end

    # Documented below, see default_connection
    #
    # source://faraday-1.10.0/lib/faraday.rb:84
    def default_connection=(_arg0); end

    # Gets the default connection options used when calling {Faraday#new}.
    #
    # @return [Faraday::ConnectionOptions]
    #
    # source://faraday-1.10.0/lib/faraday.rb:162
    def default_connection_options; end

    # Sets the default options used when calling {Faraday#new}.
    #
    # @param options [Hash, Faraday::ConnectionOptions]
    #
    # source://faraday-1.10.0/lib/faraday.rb:169
    def default_connection_options=(options); end

    # Tells Faraday to ignore the environment proxy (http_proxy).
    # Defaults to `false`.
    #
    # @return [Boolean]
    #
    # source://faraday-1.10.0/lib/faraday.rb:89
    def ignore_env_proxy; end

    # Tells Faraday to ignore the environment proxy (http_proxy).
    # Defaults to `false`.
    #
    # @return [Boolean]
    #
    # source://faraday-1.10.0/lib/faraday.rb:89
    def ignore_env_proxy=(_arg0); end

    # Gets or sets the path that the Faraday libs are loaded from.
    #
    # @return [String]
    #
    # source://faraday-1.10.0/lib/faraday.rb:72
    def lib_path; end

    # Gets or sets the path that the Faraday libs are loaded from.
    #
    # @return [String]
    #
    # source://faraday-1.10.0/lib/faraday.rb:72
    def lib_path=(_arg0); end

    # Initializes a new {Connection}.
    #
    # @example With an URL argument
    #   Faraday.new 'http://faraday.com'
    #   # => Faraday::Connection to http://faraday.com
    # @example With everything in an options hash
    #   Faraday.new url: 'http://faraday.com',
    #   params: { page: 1 }
    #   # => Faraday::Connection to http://faraday.com?page=1
    # @example With an URL argument and an options hash
    #   Faraday.new 'http://faraday.com', params: { page: 1 }
    #   # => Faraday::Connection to http://faraday.com?page=1
    # @option options
    # @option options
    # @option options
    # @option options
    # @option options
    # @option options
    # @param url [String, Hash] The optional String base URL to use as a prefix
    #   for all requests.  Can also be the options Hash. Any of these
    #   values will be set on every request made, unless overridden
    #   for a specific request.
    # @param options [Hash]
    # @return [Faraday::Connection]
    #
    # source://faraday-1.10.0/lib/faraday.rb:118
    def new(url = T.unsafe(nil), options = T.unsafe(nil), &block); end

    # Internal: Requires internal Faraday libraries.
    #
    # @param libs [Array] one or more relative String names to Faraday classes.
    # @private
    # @return [void]
    #
    # source://faraday-1.10.0/lib/faraday.rb:128
    def require_lib(*libs); end

    # Internal: Requires internal Faraday libraries.
    #
    # @param libs [Array] one or more relative String names to Faraday classes.
    # @private
    # @return [void]
    #
    # source://faraday-1.10.0/lib/faraday.rb:128
    def require_libs(*libs); end

    # @return [Boolean]
    #
    # source://faraday-1.10.0/lib/faraday.rb:142
    def respond_to_missing?(symbol, include_private = T.unsafe(nil)); end

    # The root path that Faraday is being loaded from.
    #
    # This is the root from where the libraries are auto-loaded.
    #
    # @return [String]
    #
    # source://faraday-1.10.0/lib/faraday.rb:68
    def root_path; end

    # The root path that Faraday is being loaded from.
    #
    # This is the root from where the libraries are auto-loaded.
    #
    # @return [String]
    #
    # source://faraday-1.10.0/lib/faraday.rb:68
    def root_path=(_arg0); end

    private

    # Internal: Proxies method calls on the Faraday constant to
    # .default_connection.
    #
    # source://faraday-1.10.0/lib/faraday.rb:178
    def method_missing(name, *args, &block); end
  end
end

# Adapter is the base class for all Faraday adapters.
#
# @see lib/faraday/adapter.rb Original class location
#
# source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:4
class Faraday::Adapter
  # @return [Adapter] a new instance of Adapter
  #
  # source://faraday-1.10.0/lib/faraday/adapter.rb:33
  def initialize(_app = T.unsafe(nil), opts = T.unsafe(nil), &block); end

  # source://faraday-1.10.0/lib/faraday/adapter.rb:60
  def call(env); end

  # Close any persistent connections. The adapter should still be usable
  # after calling close.
  #
  # source://faraday-1.10.0/lib/faraday/adapter.rb:55
  def close; end

  # Yields or returns an adapter's configured connection. Depends on
  # #build_connection being defined on this adapter.
  #
  # @param env [Faraday::Env, Hash] The env object for a faraday request.
  # @return The return value of the given block, or the HTTP connection object
  #   if no block is given.
  # @yield [conn]
  #
  # source://faraday-1.10.0/lib/faraday/adapter.rb:46
  def connection(env); end

  private

  # Fetches either a read, write, or open timeout setting. Defaults to the
  # :timeout value if a more specific one is not given.
  #
  # @param type [Symbol] Describes which timeout setting to get: :read,
  #   :write, or :open.
  # @param options [Hash] Hash containing Symbol keys like :timeout,
  #   :read_timeout, :write_timeout, :open_timeout, or
  #   :timeout
  # @return [Integer, nil] Timeout duration in seconds, or nil if no timeout
  #   has been set.
  #
  # source://faraday-1.10.0/lib/faraday/adapter.rb:91
  def request_timeout(type, options); end

  # source://faraday-1.10.0/lib/faraday/adapter.rb:67
  def save_response(env, status, body, headers = T.unsafe(nil), reason_phrase = T.unsafe(nil)); end
end

# source://faraday-1.10.0/lib/faraday/adapter.rb:10
Faraday::Adapter::CONTENT_LENGTH = T.let(T.unsafe(nil), String)

# Excon adapter.
#
# source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:6
class Faraday::Adapter::Excon < ::Faraday::Adapter
  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:9
  def build_connection(env); end

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:14
  def call(env); end

  # TODO: support streaming requests
  #
  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:47
  def read_body(env); end

  private

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:108
  def amend_opts_with_proxy_settings!(opts, req); end

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:81
  def amend_opts_with_ssl!(opts, ssl); end

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:94
  def amend_opts_with_timeouts!(opts, req); end

  # @return [Boolean]
  #
  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:65
  def needs_ssl_settings?(env); end

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:53
  def opts_from_env(env); end

  # source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:112
  def proxy_settings_for_opts(proxy); end
end

# source://faraday-excon-1.1.0/lib/faraday/adapter/excon.rb:69
Faraday::Adapter::Excon::OPTS_KEYS = T.let(T.unsafe(nil), Array)

# source://faraday-1.10.0/lib/faraday/adapter.rb:99
Faraday::Adapter::TIMEOUT_KEYS = T.let(T.unsafe(nil), Hash)

# source://faraday-1.10.0/lib/faraday.rb:60
Faraday::CONTENT_TYPE = T.let(T.unsafe(nil), String)

# source://faraday-multipart-1.0.4/lib/faraday/multipart.rb:18
Faraday::CompositeReadIO = Faraday::Multipart::CompositeReadIO

# Main Faraday::Excon module
#
# source://faraday-excon-1.1.0/lib/faraday/excon/version.rb:4
module Faraday::Excon; end

# source://faraday-excon-1.1.0/lib/faraday/excon/version.rb:5
Faraday::Excon::VERSION = T.let(T.unsafe(nil), String)

# source://faraday-multipart-1.0.4/lib/faraday/multipart.rb:15
Faraday::FilePart = Multipart::Post::UploadIO

# source://faraday-1.10.0/lib/faraday/methods.rb:5
Faraday::METHODS_WITH_BODY = T.let(T.unsafe(nil), Array)

# source://faraday-1.10.0/lib/faraday/methods.rb:4
Faraday::METHODS_WITH_QUERY = T.let(T.unsafe(nil), Array)

# source://faraday-multipart-1.0.4/lib/faraday/multipart.rb:16
Faraday::ParamPart = Faraday::Multipart::ParamPart

# source://faraday-multipart-1.0.4/lib/faraday/multipart.rb:17
Faraday::Parts = Multipart::Post::Parts

# source://faraday-1.10.0/lib/faraday.rb:12
Faraday::Timer = Timeout

# source://faraday-multipart-1.0.4/lib/faraday/multipart.rb:21
Faraday::UploadIO = Multipart::Post::UploadIO

# source://faraday-1.10.0/lib/faraday/version.rb:4
Faraday::VERSION = T.let(T.unsafe(nil), String)
