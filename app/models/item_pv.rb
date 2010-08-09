#商品属性信息
class ItemPv < ActiveRecord::Base
  belongs_to :item,:foreign_key => 'num_iid'
end
