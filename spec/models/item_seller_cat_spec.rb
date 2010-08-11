require 'spec_helper'

describe ItemSellerCat do
  before(:each) do
    @valid_attributes = {
      :num_iid => 1,
      :cid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ItemSellerCat.create!(@valid_attributes)
  end
end
