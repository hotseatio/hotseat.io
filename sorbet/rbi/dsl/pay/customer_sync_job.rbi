# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Pay::CustomerSyncJob`.
# Please instead update this file by running `bin/tapioca dsl Pay::CustomerSyncJob`.

class Pay::CustomerSyncJob
  class << self
    sig { params(pay_customer_id: T.untyped).returns(T.any(Pay::CustomerSyncJob, FalseClass)) }
    def perform_later(pay_customer_id); end

    sig { params(pay_customer_id: T.untyped).returns(T.untyped) }
    def perform_now(pay_customer_id); end
  end
end
