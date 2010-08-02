require 'spec_helper'

describe "/items/new.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = stub_model(Item,
      :new_record? => true,
      :iid => "value for iid",
      :num_iid => 1
    )
  end

  it "renders new item form" do
    render

    response.should have_tag("form[action=?][method=post]", items_path) do
      with_tag("input#item_iid[name=?]", "item[iid]")
      with_tag("input#item_num_iid[name=?]", "item[num_iid]")
    end
  end
end
