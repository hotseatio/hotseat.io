# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `Ascii85` gem.
# Please instead update this file by running `bin/tapioca sync`.

# typed: strict

module Ascii85
  class << self
    def decode(str); end
    def encode(str, wrap_lines = T.unsafe(nil)); end
  end
end

class Ascii85::DecodingError < ::StandardError; end
