require 'taobao/model'

module Taobao
  class ItemImg < Model
    def self.elm_name
      "item_img"
    end
    
    def self.attr_names
      [
       :id,
       :url,
       :position,
       :created
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
