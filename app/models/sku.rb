class Sku < ActiveRecord::Base
  set_primary_key :sku_id
  belongs_to :item,:foreign_key => :num_iid

  def properties
  end
  def properties=(p)
  end
end
