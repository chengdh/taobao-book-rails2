class ItemImg < ActiveRecord::Base
  belongs_to :base_item,:foreign_key => "num_iid"
end
