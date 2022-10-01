# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `digest` gem.
# Please instead update this file by running `bin/tapioca gem digest`.

module Digest
  class << self
    def const_missing(name); end
  end
end

class Digest::Class
  include ::Digest::Instance

  class << self
    # Returns the base64 encoded hash value of a given _string_.  The
    # return value is properly padded with '=' and contains no line
    # feeds.
    def base64digest(str, *args); end

    # Creates a digest object and reads a given file, _name_.
    # Optional arguments are passed to the constructor of the digest
    # class.
    #
    #   p Digest::SHA256.file("X11R6.8.2-src.tar.bz2").hexdigest
    #   # => "f02e3c85572dc9ad7cb77c2a638e3be24cc1b5bea9fdbb0b0299c9668475c534"
    def file(name, *args); end
  end
end

module Digest::Instance
  # If none is given, returns the resulting hash value of the digest
  # in a base64 encoded form, keeping the digest's state.
  #
  # If a +string+ is given, returns the hash value for the given
  # +string+ in a base64 encoded form, resetting the digest to the
  # initial state before and after the process.
  #
  # In either case, the return value is properly padded with '=' and
  # contains no line feeds.
  def base64digest(str = T.unsafe(nil)); end

  # Returns the resulting hash value and resets the digest to the
  # initial state.
  def base64digest!; end

  # Updates the digest with the contents of a given file _name_ and
  # returns self.
  def file(name); end
end

# A meta digest provider class for SHA256, SHA384 and SHA512.
#
# FIPS 180-2 describes SHA2 family of digest algorithms. It defines
# three algorithms:
# * one which works on chunks of 512 bits and returns a 256-bit
#   digest (SHA256),
# * one which works on chunks of 1024 bits and returns a 384-bit
#   digest (SHA384),
# * and one which works on chunks of 1024 bits and returns a 512-bit
#   digest (SHA512).
#
# ==Examples
#  require 'digest'
#
#  # Compute a complete digest
#  Digest::SHA2.hexdigest 'abc'          # => "ba7816bf8..."
#  Digest::SHA2.new(256).hexdigest 'abc' # => "ba7816bf8..."
#  Digest::SHA256.hexdigest 'abc'        # => "ba7816bf8..."
#
#  Digest::SHA2.new(384).hexdigest 'abc' # => "cb00753f4..."
#  Digest::SHA384.hexdigest 'abc'        # => "cb00753f4..."
#
#  Digest::SHA2.new(512).hexdigest 'abc' # => "ddaf35a19..."
#  Digest::SHA512.hexdigest 'abc'        # => "ddaf35a19..."
#
#  # Compute digest by chunks
#  sha2 = Digest::SHA2.new               # =>#<Digest::SHA2:256>
#  sha2.update "ab"
#  sha2 << "c"                           # alias for #update
#  sha2.hexdigest                        # => "ba7816bf8..."
#
#  # Use the same object to compute another digest
#  sha2.reset
#  sha2 << "message"
#  sha2.hexdigest                        # => "ab530a13e..."
class Digest::SHA2 < ::Digest::Class
  # call-seq:
  #   Digest::SHA2.new(bitlen = 256) -> digest_obj
  #
  # Create a new SHA2 hash object with a given bit length.
  #
  # Valid bit lengths are 256, 384 and 512.
  #
  # @return [SHA2] a new instance of SHA2
  def initialize(bitlen = T.unsafe(nil)); end

  # call-seq:
  #   digest_obj.update(string) -> digest_obj
  #   digest_obj << string -> digest_obj
  #
  # Update the digest using a given _string_ and return self.
  def <<(str); end

  # call-seq:
  #   digest_obj.block_length -> Integer
  #
  # Return the block length of the digest in bytes.
  #
  #   Digest::SHA256.new.block_length * 8
  #   # => 512
  #   Digest::SHA384.new.block_length * 8
  #   # => 1024
  #   Digest::SHA512.new.block_length * 8
  #   # => 1024
  def block_length; end

  # call-seq:
  #   digest_obj.digest_length -> Integer
  #
  # Return the length of the hash value (the digest) in bytes.
  #
  #   Digest::SHA256.new.digest_length * 8
  #   # => 256
  #   Digest::SHA384.new.digest_length * 8
  #   # => 384
  #   Digest::SHA512.new.digest_length * 8
  #   # => 512
  #
  # For example, digests produced by Digest::SHA256 will always be 32 bytes
  # (256 bits) in size.
  def digest_length; end

  def inspect; end

  # call-seq:
  #   digest_obj.reset -> digest_obj
  #
  # Reset the digest to the initial state and return self.
  def reset; end

  # call-seq:
  #   digest_obj.update(string) -> digest_obj
  #   digest_obj << string -> digest_obj
  #
  # Update the digest using a given _string_ and return self.
  def update(str); end

  private

  def finish; end
  def initialize_copy(other); end
end

Digest::VERSION = T.let(T.unsafe(nil), String)