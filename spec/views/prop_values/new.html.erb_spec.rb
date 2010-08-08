require 'spec_helper'

describe "/prop_values/new.html.erb" do
  include PropValuesHelper

  before(:each) do
    assigns[:prop_value] = stub_model(PropValue,
      :new_record? => true,
      :vid => 1,
      :cid => 1,
      :pid => 1,
      :prop_name => "value for prop_name",
      :name => "value for name"
    )
  end

  it "renders new prop_value form" do
    render

    response.should have_tag("form[action=?][method=post]", prop_values_path) do
      with_tag("input#prop_value_vid[name=?]", "prop_value[vid]")
      with_tag("input#prop_value_cid[name=?]", "prop_value[cid]")
      with_tag("input#prop_value_pid[name=?]", "prop_value[pid]")
      with_tag("input#prop_value_prop_name[name=?]", "prop_value[prop_name]")
      with_tag("input#prop_value_name[name=?]", "prop_value[name]")
    end
  end
end
