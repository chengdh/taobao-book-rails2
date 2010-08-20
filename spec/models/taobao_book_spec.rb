require 'spec_helper'

describe TaobaoBook do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    TaobaoBook.create!(@valid_attributes)
  end
end
