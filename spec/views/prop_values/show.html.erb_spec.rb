require 'spec_helper'

describe "/prop_values/show.html.erb" do
  include PropValuesHelper
  before(:each) do
    assigns[:prop_value] = @prop_value = stub_model(PropValue,
      :vid => 1,
      :cid => 1,
      :pid => 1,
      :prop_name => "value for prop_name",
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ prop_name/)
    response.should have_text(/value\ for\ name/)
  end
end
