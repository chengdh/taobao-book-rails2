require 'spec_helper'

describe "/postages/edit.html.erb" do
  include PostagesHelper

  before(:each) do
    assigns[:postage] = @postage = stub_model(Postage,
      :new_record? => false,
      :postage_id => 1
    )
  end

  it "renders the edit postage form" do
    render

    response.should have_tag("form[action=#{postage_path(@postage)}][method=post]") do
      with_tag('input#postage_postage_id[name=?]', "postage[postage_id]")
    end
  end
end
