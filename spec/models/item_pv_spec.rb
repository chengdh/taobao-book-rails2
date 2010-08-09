require 'spec_helper'

describe ItemPv do
  before(:each) do
    @valid_attributes = {
      :num_iid => 1,
      :pid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ItemPv.create!(@valid_attributes)
  end
end
