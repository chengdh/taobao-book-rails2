require 'spec_helper'

describe SellerCat do
  before(:each) do
    @valid_attributes = {
      :cid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    SellerCat.create!(@valid_attributes)
  end
end
