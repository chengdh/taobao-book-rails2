require 'spec_helper'

describe "/areas/index.html.erb" do
  include AreasHelper

  before(:each) do
    assigns[:areas] = [
      stub_model(Area,
        :id => 1,
        :area_type => 1,
        :name => "value for name",
        :parent_id => 1,
        :zip => "value for zip"
      ),
      stub_model(Area,
        :id => 1,
        :area_type => 1,
        :name => "value for name",
        :parent_id => 1,
        :zip => "value for zip"
      )
    ]
  end

  it "renders a list of areas" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for zip".to_s, 2)
  end
end
