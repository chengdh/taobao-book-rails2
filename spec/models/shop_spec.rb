require 'spec_helper'

describe Shop do
  before(:each) do
    @valid_attributes = {
      :sid => 1,
      :cid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Shop.create!(@valid_attributes)
  end
end
