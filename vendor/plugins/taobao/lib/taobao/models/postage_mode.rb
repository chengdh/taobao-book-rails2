require 'taobao/model'
#邮费模板
module Taobao
  class PostageMode < Model
    def self.elm_name
      "postage_mode"
    end
    
    def self.attr_names
      [
       :postage_id,
       :id,
       :type,
       :dests,
       :price,
       :increase
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
