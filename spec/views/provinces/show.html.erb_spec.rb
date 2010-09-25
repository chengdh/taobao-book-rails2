require 'spec_helper'

describe "/provinces/show.html.erb" do
  include ProvincesHelper
  before(:each) do
    assigns[:province] = @province = stub_model(Province,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
