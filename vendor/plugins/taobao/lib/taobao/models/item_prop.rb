require 'taobao/model'

module Taobao
  class ItemProp < Model
    def self.elm_name
      "item_prop"
    end
    
    def self.attr_names
      [
       :pid,
       :parent_pid,
       :parent_vid,
       :name,
       :is_key_prop,
       :is_sale_prop,
       :is_color_prop,
       :is_enum_prop,
       :is_input_prop,
       :is_item_prop,
       :must,
       :multi,
       :prop_values,
       :status,
       :sort_order,
       :child_template,
       :is_allow_alias
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
