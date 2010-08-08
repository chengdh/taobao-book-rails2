require 'spec_helper'

describe ItemProp do
  before(:each) do
    @valid_attributes = {
      :p_id => 1,
      :c_id => 1,
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    ItemProp.create!(@valid_attributes)
  end
end
