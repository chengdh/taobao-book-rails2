require 'spec_helper'

describe "/item_props/show.html.erb" do
  include ItemPropsHelper
  before(:each) do
    assigns[:item_prop] = @item_prop = stub_model(ItemProp,
      :p_id => 1,
      :c_id => 1,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ name/)
  end
end
