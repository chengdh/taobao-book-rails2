require 'taobao/model'
#邮费模板
module Taobao
  class Postage < Model
    def self.elm_name
      "postage"
    end
    
    def self.attr_names
      [
       :postage_id,
       :name,
       :memo,
       :post_price,
       :post_increase,
       :express_price,
       :express_increase,
       :ems_price,
       :ems_increase,
       :created,
       :modified,
       :postage_modes   #运费子模板
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
