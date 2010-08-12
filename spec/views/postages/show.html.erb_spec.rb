require 'spec_helper'

describe "/postages/show.html.erb" do
  include PostagesHelper
  before(:each) do
    assigns[:postage] = @postage = stub_model(Postage,
      :postage_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
