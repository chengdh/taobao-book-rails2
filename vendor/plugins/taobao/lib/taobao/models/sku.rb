require 'taobao/model'

module Taobao
  class Sku < Model
    def self.elm_name
      "sku"
    end

    def self.attr_names
      [
       :sku_id,
       :iid,
       :num_iid,
       :properties,
       :quantity,
       :price,
       :outer_id,
       :created,
       :modified,
       :status
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
