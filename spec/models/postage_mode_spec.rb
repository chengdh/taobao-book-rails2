require 'spec_helper'

describe PostageMode do
  before(:each) do
    @valid_attributes = {
      :postage_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PostageMode.create!(@valid_attributes)
  end
end
