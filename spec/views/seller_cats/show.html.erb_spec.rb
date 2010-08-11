require 'spec_helper'

describe "/seller_cats/show.html.erb" do
  include SellerCatsHelper
  before(:each) do
    assigns[:seller_cat] = @seller_cat = stub_model(SellerCat,
      :cid => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
