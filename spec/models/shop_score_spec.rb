require 'spec_helper'

describe ShopScore do
  before(:each) do
    @valid_attributes = {
      :sid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ShopScore.create!(@valid_attributes)
  end
end
