require 'spec_helper'

describe "/item_props/new.html.erb" do
  include ItemPropsHelper

  before(:each) do
    assigns[:item_prop] = stub_model(ItemProp,
      :new_record? => true,
      :p_id => 1,
      :c_id => 1,
      :name => "value for name"
    )
  end

  it "renders new item_prop form" do
    render

    response.should have_tag("form[action=?][method=post]", item_props_path) do
      with_tag("input#item_prop_p_id[name=?]", "item_prop[p_id]")
      with_tag("input#item_prop_c_id[name=?]", "item_prop[c_id]")
      with_tag("input#item_prop_name[name=?]", "item_prop[name]")
    end
  end
end
