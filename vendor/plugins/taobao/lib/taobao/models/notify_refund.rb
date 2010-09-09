require 'taobao/model'

module Taobao
  class NotifyRefund < Model
    def self.elm_name
      "notify_refund"
    end

    def self.attr_names
      [
        :rid,
        :tid,
        :oid,
        :seller_nick,
        :buyer_nick,
        :refund_fee,
        :status,
        :modified
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
