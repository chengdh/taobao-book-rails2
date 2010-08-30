require 'spec_helper'

describe Area do
  before(:each) do
    @valid_attributes = {
      :id => 1,
      :area_type => 1,
      :name => "value for name",
      :parent_id => 1,
      :zip => "value for zip"
    }
  end

  it "should create a new instance given valid attributes" do
    Area.create!(@valid_attributes)
  end
end
