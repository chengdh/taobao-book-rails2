require 'spec_helper'

describe "/provinces/index.html.erb" do
  include ProvincesHelper

  before(:each) do
    assigns[:provinces] = [
      stub_model(Province,
        :name => "value for name"
      ),
      stub_model(Province,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of provinces" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
