require 'spec_helper'

describe "/seller_cats/edit.html.erb" do
  include SellerCatsHelper

  before(:each) do
    assigns[:seller_cat] = @seller_cat = stub_model(SellerCat,
      :new_record? => false,
      :cid => 1
    )
  end

  it "renders the edit seller_cat form" do
    render

    response.should have_tag("form[action=#{seller_cat_path(@seller_cat)}][method=post]") do
      with_tag('input#seller_cat_cid[name=?]', "seller_cat[cid]")
    end
  end
end
