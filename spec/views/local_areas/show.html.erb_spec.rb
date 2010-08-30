require 'spec_helper'

describe "/areas/show.html.erb" do
  include AreasHelper
  before(:each) do
    assigns[:area] = @area = stub_model(Area,
      :id => 1,
      :area_type => 1,
      :name => "value for name",
      :parent_id => 1,
      :zip => "value for zip"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ zip/)
  end
end
