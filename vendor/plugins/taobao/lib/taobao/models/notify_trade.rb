require 'taobao/model'

module Taobao
  class NotifyTrade < Model
    def self.elm_name
      "notify_trade"
    end

    def self.attr_names
      [
        :tid,
        :seller_nick,
        :buyer_nick,
        :payment,
        :is_3D,
        :type,
        :status,
        :modified
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
