require 'spec_helper'

describe UserCredit do
  before(:each) do
    @valid_attributes = {
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    UserCredit.create!(@valid_attributes)
  end
end
