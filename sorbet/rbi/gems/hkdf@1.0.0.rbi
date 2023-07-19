# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `hkdf` gem.
# Please instead update this file by running `bin/tapioca gem hkdf`.

# Provide HMAC-based Extract-and-Expand Key Derivation Function (HKDF) for Ruby.
#
# source://hkdf//lib/hkdf.rb#7
class HKDF
  # Create a new HKDF instance with then provided +source+ key material.
  #
  # Options:
  # - +algorithm:+ hash function to use (defaults to SHA-256)
  # - +info:+ optional context and application specific information
  # - +salt:+ optional salt value (a non-secret random value)
  # - +read_size:+ buffer size when reading from a source IO
  #
  # @return [HKDF] a new instance of HKDF
  #
  # source://hkdf//lib/hkdf.rb#20
  def initialize(source, options = T.unsafe(nil)); end

  # Returns the hash algorithm this instance was configured with.
  #
  # source://hkdf//lib/hkdf.rb#37
  def algorithm; end

  # source://hkdf//lib/hkdf.rb#79
  def inspect; end

  # Maximum length that can be derived per the RFC.
  #
  # source://hkdf//lib/hkdf.rb#42
  def max_length; end

  # Read the next +length+ bytes from the stream. Will raise +RangeError+ if you attempt to read beyond +#max_length+.
  #
  # @raise [RangeError]
  #
  # source://hkdf//lib/hkdf.rb#60
  def read(length); end

  # Read the next +length+ bytes from the stream and return them hex encoded. Will raise +RangeError+ if you attempt to
  # read beyond +#max_length+.
  #
  # source://hkdf//lib/hkdf.rb#74
  def read_hex(length); end

  # Adjust reading position back to the beginning.
  #
  # source://hkdf//lib/hkdf.rb#55
  def rewind; end

  # Adjust the reading position to an arbitrary offset. Will raise +RangeError+ if you attempt to seek longer than
  # +#max_length+.
  #
  # @raise [RangeError]
  #
  # source://hkdf//lib/hkdf.rb#48
  def seek(position); end

  private

  # source://hkdf//lib/hkdf.rb#93
  def generate_blocks(length); end

  # source://hkdf//lib/hkdf.rb#85
  def generate_prk(salt, source, read_size); end
end

# Default hash algorithm to use for HMAC.
#
# source://hkdf//lib/hkdf.rb#9
HKDF::DEFAULT_ALGOTIHM = T.let(T.unsafe(nil), String)

# Default buffer size for reading source IO.
#
# source://hkdf//lib/hkdf.rb#11
HKDF::DEFAULT_READ_SIZE = T.let(T.unsafe(nil), Integer)
