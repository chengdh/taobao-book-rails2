require 'spec_helper'

describe ItemImg do
  before(:each) do
    @valid_attributes = {
      :id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ItemImg.create!(@valid_attributes)
  end
end
