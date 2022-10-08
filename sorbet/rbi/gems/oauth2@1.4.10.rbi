# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `oauth2` gem.
# Please instead update this file by running `bin/tapioca gem oauth2`.

# source://oauth2-1.4.10/lib/oauth2/error.rb:3
module OAuth2; end

# source://oauth2-1.4.10/lib/oauth2/access_token.rb:4
class OAuth2::AccessToken
  # Initalize an AccessToken
  #
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @param client [Client] the OAuth2::Client instance
  # @param token [String] the Access Token value
  # @param opts [Hash] the options to create the Access Token with
  # @return [AccessToken] a new instance of AccessToken
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:43
  def initialize(client, token, opts = T.unsafe(nil)); end

  # Indexer to additional params present in token response
  #
  # @param key [String] entry key to Hash
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:63
  def [](key); end

  # Returns the value of attribute client.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:5
  def client; end

  # Make a DELETE request with the Access Token
  #
  # @see AccessToken#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:145
  def delete(path, opts = T.unsafe(nil), &block); end

  # Whether or not the token is expired
  #
  # @return [Boolean]
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:77
  def expired?; end

  # Whether or not the token expires
  #
  # @return [Boolean]
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:70
  def expires?; end

  # Returns the value of attribute expires_at.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:5
  def expires_at; end

  # Returns the value of attribute expires_in.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:5
  def expires_in; end

  # Make a GET request with the Access Token
  #
  # @see AccessToken#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:117
  def get(path, opts = T.unsafe(nil), &block); end

  # Get the headers hash (includes Authorization token)
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:150
  def headers; end

  # Returns the value of attribute options.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:6
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:6
  def options=(_arg0); end

  # Returns the value of attribute params.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:5
  def params; end

  # Make a PATCH request with the Access Token
  #
  # @see AccessToken#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:138
  def patch(path, opts = T.unsafe(nil), &block); end

  # Make a POST request with the Access Token
  #
  # @see AccessToken#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:124
  def post(path, opts = T.unsafe(nil), &block); end

  # Make a PUT request with the Access Token
  #
  # @see AccessToken#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:131
  def put(path, opts = T.unsafe(nil), &block); end

  # Refreshes the current Access Token
  #
  # @note options should be carried over to the new AccessToken
  # @return [AccessToken] a new AccessToken
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:85
  def refresh!(params = T.unsafe(nil)); end

  # Returns the value of attribute refresh_token.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:6
  def refresh_token; end

  # Sets the attribute refresh_token
  #
  # @param value the value to set the attribute refresh_token to.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:6
  def refresh_token=(_arg0); end

  # Make a request with the Access Token
  #
  # @param verb [Symbol] the HTTP request method
  # @param path [String] the HTTP URL path of the request
  # @param opts [Hash] the options to make the request with
  # @see Client#request
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:109
  def request(verb, path, opts = T.unsafe(nil), &block); end

  # Convert AccessToken to a hash which can be used to rebuild itself with AccessToken.from_hash
  #
  # @return [Hash] a hash of AccessToken property values
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:99
  def to_hash; end

  # Returns the value of attribute token.
  #
  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:5
  def token; end

  private

  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:156
  def configure_authentication!(opts); end

  # source://oauth2-1.4.10/lib/oauth2/access_token.rb:177
  def convert_expires_at(expires_at); end

  class << self
    # Initializes an AccessToken from a Hash
    #
    # @param the [Client] OAuth2::Client instance
    # @param a [Hash] hash of AccessToken property values
    # @return [AccessToken] the initalized AccessToken
    #
    # source://oauth2-1.4.10/lib/oauth2/access_token.rb:15
    def from_hash(client, hash); end

    # Initializes an AccessToken from a key/value application/x-www-form-urlencoded string
    #
    # @param client [Client] the OAuth2::Client instance
    # @param kvform [String] the application/x-www-form-urlencoded string
    # @return [AccessToken] the initalized AccessToken
    #
    # source://oauth2-1.4.10/lib/oauth2/access_token.rb:25
    def from_kvform(client, kvform); end
  end
end

# source://oauth2-1.4.10/lib/oauth2/authenticator.rb:6
class OAuth2::Authenticator
  # @return [Authenticator] a new instance of Authenticator
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:9
  def initialize(id, secret, mode); end

  # Apply the request credentials used to authenticate to the Authorization Server
  #
  # Depending on configuration, this might be as request params or as an
  # Authorization header.
  #
  # User-provided params and header take precedence.
  #
  # @param params [Hash] a Hash of params for the token endpoint
  # @return [Hash] params amended with appropriate authentication details
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:24
  def apply(params); end

  # Returns the value of attribute id.
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:7
  def id; end

  # Returns the value of attribute mode.
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:7
  def mode; end

  # Returns the value of attribute secret.
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:7
  def secret; end

  private

  # Adds an `Authorization` header with Basic Auth credentials if and only if
  # it is not already set in the params.
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:59
  def apply_basic_auth(params); end

  # When using schemes that don't require the client_secret to be passed i.e TLS Client Auth,
  # we don't want to send the secret
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:53
  def apply_client_id(params); end

  # Adds client_id and client_secret request parameters if they are not
  # already set.
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:47
  def apply_params_auth(params); end

  # @see https://datatracker.ietf.org/doc/html/rfc2617#section-2
  #
  # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:66
  def basic_auth_header; end

  class << self
    # source://oauth2-1.4.10/lib/oauth2/authenticator.rb:39
    def encode_basic_auth(user, password); end
  end
end

# The OAuth2::Client class
#
# source://oauth2-1.4.10/lib/oauth2/client.rb:9
class OAuth2::Client
  # Instantiate a new OAuth 2.0 client using the
  # Client ID and Client Secret registered to your
  # application.
  #
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @option options
  # @param client_id [String] the client_id value
  # @param client_secret [String] the client_secret value
  # @param options [Hash] the options to create the client with
  # @return [Client] a new instance of Client
  # @yield [builder] The Faraday connection builder
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:35
  def initialize(client_id, client_secret, options = T.unsafe(nil), &block); end

  # source://oauth2-1.4.10/lib/oauth2/client.rb:228
  def assertion; end

  # The Authorization Code strategy
  #
  # @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.1
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:203
  def auth_code; end

  # The authorize endpoint URL of the OAuth2 provider
  #
  # @param params [Hash] additional query parameters
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:79
  def authorize_url(params = T.unsafe(nil)); end

  # The Client Credentials strategy
  #
  # @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.4
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:224
  def client_credentials; end

  # The Faraday connection object
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:63
  def connection; end

  # Sets the attribute connection
  #
  # @param value the value to set the attribute connection to.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:14
  def connection=(_arg0); end

  # Initializes an AccessToken by making a request to the token endpoint
  #
  # @param params [Hash] a Hash of params for the token endpoint
  # @param access_token_opts [Hash] access token options, to pass to the AccessToken object
  # @param access_token_class [Class] class of access token for easier subclassing OAuth2::AccessToken
  # @return [AccessToken] the initialized AccessToken
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:155
  def get_token(params, access_token_opts = T.unsafe(nil), extract_access_token = T.unsafe(nil)); end

  # Returns the value of attribute id.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:12
  def id; end

  # The Implicit strategy
  #
  # @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-26#section-4.2
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:210
  def implicit; end

  # Returns the value of attribute options.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:13
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:13
  def options=(_arg0); end

  # The Resource Owner Password Credentials strategy
  #
  # @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.3
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:217
  def password; end

  # The redirect_uri parameters, if configured
  #
  # The redirect_uri query parameter is OPTIONAL (though encouraged) when
  # requesting authorization. If it is provided at authorization time it MUST
  # also be provided with the token exchange request.
  #
  # Providing the :redirect_uri to the OAuth2::Client instantiation will take
  # care of managing this.
  #
  # @api semipublic
  # @return [Hash] the params to add to a request or URL
  # @see https://datatracker.ietf.org/doc/html/rfc6749#section-4.1
  # @see https://datatracker.ietf.org/doc/html/rfc6749#section-4.1.3
  # @see https://datatracker.ietf.org/doc/html/rfc6749#section-4.2.1
  # @see https://datatracker.ietf.org/doc/html/rfc6749#section-10.6
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:248
  def redirection_params; end

  # Makes a request relative to the specified site root.
  #
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @param verb [Symbol] one of :get, :post, :put, :delete
  # @param url [String] URL path of request
  # @param opts [Hash] the options to make the request with
  # @yield [req] The Faraday request
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:103
  def request(verb, url, opts = T.unsafe(nil)); end

  # Returns the value of attribute secret.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:12
  def secret; end

  # Returns the value of attribute site.
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:12
  def site; end

  # Set the site host
  #
  # @param value [String] the OAuth2 provider site host
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:57
  def site=(value); end

  # The token endpoint URL of the OAuth2 provider
  #
  # @param params [Hash] additional query parameters
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:87
  def token_url(params = T.unsafe(nil)); end

  private

  # Returns the authenticator object
  #
  # @return [Authenticator] the initialized Authenticator
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:266
  def authenticator; end

  # Builds the access token from the response of the HTTP call
  #
  # @return [AccessToken] the initialized AccessToken
  #
  # source://oauth2-1.4.10/lib/oauth2/client.rb:273
  def build_access_token(response, access_token_opts, extract_access_token); end

  # source://oauth2-1.4.10/lib/oauth2/client.rb:288
  def oauth_debug_logging(builder); end
end

# source://oauth2-1.4.10/lib/oauth2/client.rb:256
OAuth2::Client::DEFAULT_EXTRACT_ACCESS_TOKEN = T.let(T.unsafe(nil), Proc)

# source://oauth2-1.4.10/lib/oauth2/client.rb:10
OAuth2::Client::RESERVED_PARAM_KEYS = T.let(T.unsafe(nil), Array)

# source://oauth2-1.4.10/lib/oauth2/client.rb:7
class OAuth2::ConnectionError < ::Faraday::ConnectionFailed; end

# source://oauth2-1.4.10/lib/oauth2/error.rb:4
class OAuth2::Error < ::StandardError
  # standard error values include:
  # :invalid_request, :invalid_client, :invalid_token, :invalid_grant, :unsupported_grant_type, :invalid_scope
  #
  # @return [Error] a new instance of Error
  #
  # source://oauth2-1.4.10/lib/oauth2/error.rb:9
  def initialize(response); end

  # Returns the value of attribute code.
  #
  # source://oauth2-1.4.10/lib/oauth2/error.rb:5
  def code; end

  # Returns the value of attribute description.
  #
  # source://oauth2-1.4.10/lib/oauth2/error.rb:5
  def description; end

  # Makes a error message
  #
  # @param response_body [String] response body of request
  # @param opts [String] :error_description error description to show first line
  #
  # source://oauth2-1.4.10/lib/oauth2/error.rb:25
  def error_message(response_body, opts = T.unsafe(nil)); end

  # Returns the value of attribute response.
  #
  # source://oauth2-1.4.10/lib/oauth2/error.rb:5
  def response; end
end

# source://oauth2-1.4.10/lib/oauth2/mac_token.rb:15
class OAuth2::MACToken < ::OAuth2::AccessToken
  # Initalize a MACToken
  #
  # @option [String]
  # @option opts
  # @option opts
  # @option opts
  # @option opts
  # @param client [Client] the OAuth2::Client instance
  # @param token [String] the Access Token value
  # @param opts [Hash] the options to create the Access Token with
  # @param [String] [Hash] a customizable set of options
  # @return [MACToken] a new instance of MACToken
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:32
  def initialize(client, token, secret, opts = T.unsafe(nil)); end

  # Returns the value of attribute algorithm.
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:20
  def algorithm; end

  # Set the HMAC algorithm
  #
  # @param alg [String] the algorithm to use (one of 'hmac-sha-1', 'hmac-sha-256')
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:99
  def algorithm=(alg); end

  # Generate the MAC header
  #
  # @param verb [Symbol] the HTTP request method
  # @param url [String] the HTTP URL path of the request
  # @raise [ArgumentError]
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:63
  def header(verb, url); end

  # Get the headers hash (always an empty hash)
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:55
  def headers; end

  # Make a request with the MAC Token
  #
  # @param verb [Symbol] the HTTP request method
  # @param path [String] the HTTP URL path of the request
  # @param opts [Hash] the options to make the request with
  # @see Client#request
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:45
  def request(verb, path, opts = T.unsafe(nil), &block); end

  # Returns the value of attribute secret.
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:20
  def secret; end

  # Generate the Base64-encoded HMAC digest signature
  #
  # @param timestamp [Fixnum] the timestamp of the request in seconds since epoch
  # @param nonce [String] the MAC header nonce
  # @param verb [Symbol] the HTTP request method
  # @param url [String] the HTTP URL path of the request
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:82
  def signature(timestamp, nonce, verb, uri); end

  private

  # Base64.strict_encode64 is not available on Ruby 1.8.7
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:126
  def strict_encode64(str); end

  # No-op since we need the verb and path
  # and the MAC always goes in a header
  #
  # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:122
  def token=(_noop); end

  class << self
    # Generates a MACToken from an AccessToken and secret
    #
    # @option [String]
    # @param token [AccessToken] the OAuth2::Token instance
    # @param opts [Hash] the options to create the Access Token with
    # @param [String] [Hash] a customizable set of options
    # @see MACToken#initialize
    #
    # source://oauth2-1.4.10/lib/oauth2/mac_token.rb:16
    def from_access_token(token, secret, options = T.unsafe(nil)); end
  end
end

# OAuth2::Response class
#
# source://oauth2-1.4.10/lib/oauth2/response.rb:9
class OAuth2::Response
  # Initializes a Response instance
  #
  # @option opts
  # @param response [Faraday::Response] The Faraday response instance
  # @param opts [Hash] options in which to initialize the instance
  # @return [Response] a new instance of Response
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:48
  def initialize(response, opts = T.unsafe(nil)); end

  # The HTTP response body
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:64
  def body; end

  # Attempts to determine the content type of the response.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:78
  def content_type; end

  # Returns the value of attribute error.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:11
  def error; end

  # Sets the attribute error
  #
  # @param value the value to set the attribute error to.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:11
  def error=(_arg0); end

  # The HTTP response headers
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:54
  def headers; end

  # Returns the value of attribute options.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:11
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:11
  def options=(_arg0); end

  # The parsed response body.
  #   Will attempt to parse application/x-www-form-urlencoded and
  #   application/json Content-Type response bodies
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:71
  def parsed; end

  # Determines the parser that will be used to supply the content of #parsed
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:83
  def parser; end

  # Returns the value of attribute response.
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:10
  def response; end

  # The HTTP response status code
  #
  # source://oauth2-1.4.10/lib/oauth2/response.rb:59
  def status; end

  class << self
    # Adds a new content type parser.
    #
    # @param key [Symbol] A descriptive symbol key such as :json or :query.
    # @param mime_types [Array] One or more mime types to which this parser applies.
    # @yield [String] A block returning parsed content.
    #
    # source://oauth2-1.4.10/lib/oauth2/response.rb:34
    def register_parser(key, mime_types, &block); end
  end
end

# source://oauth2-1.4.10/lib/oauth2/strategy/base.rb:4
module OAuth2::Strategy; end

# The Client Assertion Strategy
#
# Sample usage:
#   client = OAuth2::Client.new(client_id, client_secret,
#                               :site => 'http://localhost:8080')
#
#   params = {:hmac_secret => "some secret",
#             # or :private_key => "private key string",
#             :iss => "http://localhost:3001",
#             :prn => "me@here.com",
#             :exp => Time.now.utc.to_i + 3600}
#
#   access = client.assertion.get_token(params)
#   access.token                 # actual access_token string
#   access.get("/api/stuff")     # making api calls with access token in header
#
# @see https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-10#section-4.1.3
#
# source://oauth2-1.4.10/lib/oauth2/strategy/assertion.rb:28
class OAuth2::Strategy::Assertion < ::OAuth2::Strategy::Base
  # Not used for this strategy
  #
  # @raise [NotImplementedError]
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/assertion.rb:29
  def authorize_url; end

  # source://oauth2-1.4.10/lib/oauth2/strategy/assertion.rb:62
  def build_assertion(params); end

  # source://oauth2-1.4.10/lib/oauth2/strategy/assertion.rb:52
  def build_request(params); end

  # Retrieve an access token given the specified client.
  #
  # pass either :hmac_secret or :private_key, but not both.
  #
  #   params :hmac_secret, secret string.
  #   params :private_key, private key string.
  #
  #   params :iss, issuer
  #   params :aud, audience, optional
  #   params :prn, principal, current user
  #   params :exp, expired at, in seconds, like Time.now.utc.to_i + 3600
  #
  # @param params [Hash] assertion params
  # @param opts [Hash] options
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/assertion.rb:47
  def get_token(params = T.unsafe(nil), opts = T.unsafe(nil)); end
end

# The Authorization Code Strategy
#
# @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.1
#
# source://oauth2-1.4.10/lib/oauth2/strategy/auth_code.rb:11
class OAuth2::Strategy::AuthCode < ::OAuth2::Strategy::Base
  # The required query parameters for the authorize URL
  #
  # @param params [Hash] additional query parameters
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/auth_code.rb:12
  def authorize_params(params = T.unsafe(nil)); end

  # The authorization URL endpoint of the provider
  #
  # @param params [Hash] additional query parameters for the URL
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/auth_code.rb:19
  def authorize_url(params = T.unsafe(nil)); end

  # Retrieve an access token given the specified validation code.
  #
  # @note that you must also provide a :redirect_uri with most OAuth 2.0 providers
  # @param code [String] The Authorization Code value
  # @param params [Hash] additional params
  # @param opts [Hash] options
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/auth_code.rb:29
  def get_token(code, params = T.unsafe(nil), opts = T.unsafe(nil)); end
end

# source://oauth2-1.4.10/lib/oauth2/strategy/base.rb:5
class OAuth2::Strategy::Base
  # @return [Base] a new instance of Base
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/base.rb:6
  def initialize(client); end
end

# The Client Credentials Strategy
#
# @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.4
#
# source://oauth2-1.4.10/lib/oauth2/strategy/client_credentials.rb:11
class OAuth2::Strategy::ClientCredentials < ::OAuth2::Strategy::Base
  # Not used for this strategy
  #
  # @raise [NotImplementedError]
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/client_credentials.rb:12
  def authorize_url; end

  # Retrieve an access token given the specified client.
  #
  # @param params [Hash] additional params
  # @param opts [Hash] options
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/client_credentials.rb:20
  def get_token(params = T.unsafe(nil), opts = T.unsafe(nil)); end
end

# The Implicit Strategy
#
# @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-26#section-4.2
#
# source://oauth2-1.4.10/lib/oauth2/strategy/implicit.rb:11
class OAuth2::Strategy::Implicit < ::OAuth2::Strategy::Base
  # The required query parameters for the authorize URL
  #
  # @param params [Hash] additional query parameters
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/implicit.rb:12
  def authorize_params(params = T.unsafe(nil)); end

  # The authorization URL endpoint of the provider
  #
  # @param params [Hash] additional query parameters for the URL
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/implicit.rb:19
  def authorize_url(params = T.unsafe(nil)); end

  # Not used for this strategy
  #
  # @raise [NotImplementedError]
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/implicit.rb:26
  def get_token(*_arg0); end
end

# The Resource Owner Password Credentials Authorization Strategy
#
# @see http://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-15#section-4.3
#
# source://oauth2-1.4.10/lib/oauth2/strategy/password.rb:11
class OAuth2::Strategy::Password < ::OAuth2::Strategy::Base
  # Not used for this strategy
  #
  # @raise [NotImplementedError]
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/password.rb:12
  def authorize_url; end

  # Retrieve an access token given the specified End User username and password.
  #
  # @param username [String] the End User username
  # @param password [String] the End User password
  # @param params [Hash] additional params
  #
  # source://oauth2-1.4.10/lib/oauth2/strategy/password.rb:21
  def get_token(username, password, params = T.unsafe(nil), opts = T.unsafe(nil)); end
end
