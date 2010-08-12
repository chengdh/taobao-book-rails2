require 'spec_helper'

describe "/postages/index.html.erb" do
  include PostagesHelper

  before(:each) do
    assigns[:postages] = [
      stub_model(Postage,
        :postage_id => 1
      ),
      stub_model(Postage,
        :postage_id => 1
      )
    ]
  end

  it "renders a list of postages" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
