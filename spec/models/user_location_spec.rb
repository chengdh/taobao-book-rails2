require 'spec_helper'

describe UserLocation do
  before(:each) do
    @valid_attributes = {
      :zip => "value for zip"
    }
  end

  it "should create a new instance given valid attributes" do
    UserLocation.create!(@valid_attributes)
  end
end
