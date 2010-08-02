require 'spec_helper'

describe "/items/edit.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
      :iid => "value for iid",
      :num_iid => 1
    )
  end

  it "renders the edit item form" do
    render

    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_iid[name=?]', "item[iid]")
      with_tag('input#item_num_iid[name=?]', "item[num_iid]")
    end
  end
end
