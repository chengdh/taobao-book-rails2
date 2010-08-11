class ShopScore < ActiveRecord::Base
  set_primary_key :sid
  belongs_to :shop,:foreign_key => :sid
end
