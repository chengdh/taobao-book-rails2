require 'spec_helper'

describe "/item_props/edit.html.erb" do
  include ItemPropsHelper

  before(:each) do
    assigns[:item_prop] = @item_prop = stub_model(ItemProp,
      :new_record? => false,
      :p_id => 1,
      :c_id => 1,
      :name => "value for name"
    )
  end

  it "renders the edit item_prop form" do
    render

    response.should have_tag("form[action=#{item_prop_path(@item_prop)}][method=post]") do
      with_tag('input#item_prop_p_id[name=?]', "item_prop[p_id]")
      with_tag('input#item_prop_c_id[name=?]', "item_prop[c_id]")
      with_tag('input#item_prop_name[name=?]', "item_prop[name]")
    end
  end
end
