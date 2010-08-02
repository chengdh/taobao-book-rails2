require 'taobao/model'

module Taobao
  class ItemCategory < Model
    def self.elm_name
      "item_category"
    end

    def self.attr_names
      [
       :category_id,
       :count
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
