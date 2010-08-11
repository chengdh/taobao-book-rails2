require 'taobao/model'
#店铺积分
module Taobao
  class ShopScore < Model
    def self.elm_name
      "shop_score"
    end

    def self.attr_names
      [
        :item_score,
        :service_score,
        :delivery_score
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
