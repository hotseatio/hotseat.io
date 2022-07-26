# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `safely_block` gem.
# Please instead update this file by running `bin/tapioca sync`.

# typed: strict

module Safely
  extend ::Safely::Methods

  class << self
    def env; end
    def env=(_arg0); end
    def raise_envs; end
    def raise_envs=(_arg0); end
    def report_exception(e, tag: T.unsafe(nil), context: T.unsafe(nil)); end
    def report_exception_method; end
    def report_exception_method=(_arg0); end
    def tag; end
    def tag=(_arg0); end
    def throttle_counter; end
    def throttle_counter=(_arg0); end
    def throttled?(e, options); end
  end
end

Safely::DEFAULT_EXCEPTION_METHOD = T.let(T.unsafe(nil), Proc)

module Safely::Methods
  def safely(tag: T.unsafe(nil), sample: T.unsafe(nil), except: T.unsafe(nil), only: T.unsafe(nil), silence: T.unsafe(nil), throttle: T.unsafe(nil), default: T.unsafe(nil), context: T.unsafe(nil)); end
  def yolo(tag: T.unsafe(nil), sample: T.unsafe(nil), except: T.unsafe(nil), only: T.unsafe(nil), silence: T.unsafe(nil), throttle: T.unsafe(nil), default: T.unsafe(nil), context: T.unsafe(nil)); end
end

Safely::VERSION = T.let(T.unsafe(nil), String)
