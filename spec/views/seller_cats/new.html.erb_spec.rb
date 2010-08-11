require 'spec_helper'

describe "/seller_cats/new.html.erb" do
  include SellerCatsHelper

  before(:each) do
    assigns[:seller_cat] = stub_model(SellerCat,
      :new_record? => true,
      :cid => 1
    )
  end

  it "renders new seller_cat form" do
    render

    response.should have_tag("form[action=?][method=post]", seller_cats_path) do
      with_tag("input#seller_cat_cid[name=?]", "seller_cat[cid]")
    end
  end
end
