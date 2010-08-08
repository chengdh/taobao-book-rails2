require 'spec_helper'

describe "/prop_values/index.html.erb" do
  include PropValuesHelper

  before(:each) do
    assigns[:prop_values] = [
      stub_model(PropValue,
        :vid => 1,
        :cid => 1,
        :pid => 1,
        :prop_name => "value for prop_name",
        :name => "value for name"
      ),
      stub_model(PropValue,
        :vid => 1,
        :cid => 1,
        :pid => 1,
        :prop_name => "value for prop_name",
        :name => "value for name"
      )
    ]
  end

  it "renders a list of prop_values" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for prop_name".to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
