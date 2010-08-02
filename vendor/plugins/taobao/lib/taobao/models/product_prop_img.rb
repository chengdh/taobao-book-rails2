require 'taobao/model'

module Taobao
  class ProductPropImg < Model
    def self.elm_name
      "product_prop_img"
    end

    def self.attr_names
      [
       :pic_id,
       :props,
       :url,
       :position,
       :modified,
       :created,
       :product_id
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
