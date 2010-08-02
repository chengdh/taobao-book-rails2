require 'spec_helper'

describe ItemCat do
  before(:each) do
    @valid_attributes = {
      :cid => 1,
      :parent_cid => 1,
      :name => "value for name",
      :is_parent => false,
      :status => "value for status",
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ItemCat.create!(@valid_attributes)
  end
end
