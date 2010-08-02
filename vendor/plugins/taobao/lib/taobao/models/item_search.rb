#
# http://wiki.open.taobao.com/index.php/ItemSearch
#

require 'taobao/model'

module Taobao
  class ItemSearch < Model
    def self.elm_name
      "item_search"
    end

    def self.attr_names
      [
       :items,
       :item_categories
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
