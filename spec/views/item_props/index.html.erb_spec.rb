require 'spec_helper'

describe "/item_props/index.html.erb" do
  include ItemPropsHelper

  before(:each) do
    assigns[:item_props] = [
      stub_model(ItemProp,
        :p_id => 1,
        :c_id => 1,
        :name => "value for name"
      ),
      stub_model(ItemProp,
        :p_id => 1,
        :c_id => 1,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of item_props" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
