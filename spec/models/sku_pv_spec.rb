require 'spec_helper'

describe SkuPv do
  before(:each) do
    @valid_attributes = {
      :sku_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    SkuPv.create!(@valid_attributes)
  end
end
