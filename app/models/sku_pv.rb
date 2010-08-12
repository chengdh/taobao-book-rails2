class SkuPv < ActiveRecord::Base
  belongs_to :sku,:foreign_key => :sku_id
end
