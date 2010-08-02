require 'spec_helper'

describe "/items/index.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :iid => "value for iid",
        :num_iid => 1
      ),
      stub_model(Item,
        :iid => "value for iid",
        :num_iid => 1
      )
    ]
  end

  it "renders a list of items" do
    render
    response.should have_tag("tr>td", "value for iid".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
