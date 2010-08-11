require 'spec_helper'

describe "/seller_cats/index.html.erb" do
  include SellerCatsHelper

  before(:each) do
    assigns[:seller_cats] = [
      stub_model(SellerCat,
        :cid => 1
      ),
      stub_model(SellerCat,
        :cid => 1
      )
    ]
  end

  it "renders a list of seller_cats" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
