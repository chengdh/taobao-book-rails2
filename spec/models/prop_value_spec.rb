require 'spec_helper'

describe PropValue do
  before(:each) do
    @valid_attributes = {
      :vid => 1,
      :cid => 1,
      :pid => 1,
      :prop_name => "value for prop_name",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    PropValue.create!(@valid_attributes)
  end
end
