require 'spec_helper'

describe "/postages/new.html.erb" do
  include PostagesHelper

  before(:each) do
    assigns[:postage] = stub_model(Postage,
      :new_record? => true,
      :postage_id => 1
    )
  end

  it "renders new postage form" do
    render

    response.should have_tag("form[action=?][method=post]", postages_path) do
      with_tag("input#postage_postage_id[name=?]", "postage[postage_id]")
    end
  end
end
