require 'taobao/model'

module Taobao
  class NotifyItem < Model
    def self.elm_name
      "notify_item"
    end

    def self.attr_names
      [
       :iid,
       :nick,
       :num,
       :num_iid,
       :title,
       :status,
       :change_fields,
       :price,
       :modified
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
