require 'taobao/model'

module Taobao
  class Area < Model
    def self.elm_name
      "area"
    end

    def self.attr_names
      [
       :id,
       :type,
       :name,
       :parent_id,
       :zip
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
