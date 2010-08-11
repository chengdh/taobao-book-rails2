class ItemImg < ActiveRecord::Base
  belongs_to :item,:foreign_key => "num_iid"
end
