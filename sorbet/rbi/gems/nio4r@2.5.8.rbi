# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `nio4r` gem.
# Please instead update this file by running `bin/tapioca sync`.

# typed: true

module NIO
  class << self
    def engine; end
    def pure?(env = T.unsafe(nil)); end
  end
end

class NIO::ByteBuffer
  include ::Enumerable

  def initialize(_arg0); end

  def <<(_arg0); end
  def [](_arg0); end
  def capacity; end
  def clear; end
  def compact; end
  def each; end
  def flip; end
  def full?; end
  def get(*_arg0); end
  def inspect; end
  def limit; end
  def limit=(_arg0); end
  def mark; end
  def position; end
  def position=(_arg0); end
  def read_from(_arg0); end
  def remaining; end
  def reset; end
  def rewind; end
  def size; end
  def write_to(_arg0); end
end

class NIO::ByteBuffer::MarkUnsetError < ::IOError; end
class NIO::ByteBuffer::OverflowError < ::IOError; end
class NIO::ByteBuffer::UnderflowError < ::IOError; end
NIO::ENGINE = T.let(T.unsafe(nil), String)

class NIO::Monitor
  def initialize(_arg0, _arg1, _arg2); end

  def add_interest(_arg0); end
  def close(*_arg0); end
  def closed?; end
  def interests; end
  def interests=(_arg0); end
  def io; end
  def readable?; end
  def readiness; end
  def remove_interest(_arg0); end
  def selector; end
  def value; end
  def value=(_arg0); end
  def writable?; end
  def writeable?; end
end

class NIO::Selector
  def initialize(*_arg0); end

  def backend; end
  def close; end
  def closed?; end
  def deregister(_arg0); end
  def empty?; end
  def register(_arg0, _arg1); end
  def registered?(_arg0); end
  def select(*_arg0); end
  def wakeup; end

  class << self
    def backends; end
  end
end

NIO::VERSION = T.let(T.unsafe(nil), String)
