require 'spec_helper'

describe Postage do
  before(:each) do
    @valid_attributes = {
      :postage_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Postage.create!(@valid_attributes)
  end
end
