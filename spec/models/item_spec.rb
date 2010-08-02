require 'spec_helper'

describe Item do
  before(:each) do
    @valid_attributes = {
      :iid => "value for iid",
      :num_iid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end
end
