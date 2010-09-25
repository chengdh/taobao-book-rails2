require 'spec_helper'

describe "/provinces/new.html.erb" do
  include ProvincesHelper

  before(:each) do
    assigns[:province] = stub_model(Province,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new province form" do
    render

    response.should have_tag("form[action=?][method=post]", provinces_path) do
      with_tag("input#province_name[name=?]", "province[name]")
    end
  end
end
