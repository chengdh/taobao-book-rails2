require 'spec_helper'

describe SynLog do
  before(:each) do
    @valid_attributes = {
      :nick => "value for nick",
      :last_syn_time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    SynLog.create!(@valid_attributes)
  end
end
