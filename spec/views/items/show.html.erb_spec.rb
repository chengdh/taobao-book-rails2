require 'spec_helper'

describe "/items/show.html.erb" do
  include ItemsHelper
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :iid => "value for iid",
      :num_iid => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ iid/)
    response.should have_text(/1/)
  end
end
