class ItemSellerCat < ActiveRecord::Base
  belongs_to :item,:foreign_key => :num_iid
  belongs_to :seller_cat,:foreign_key => :cid
end
