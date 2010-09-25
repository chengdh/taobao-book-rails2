require 'spec_helper'

describe "/provinces/edit.html.erb" do
  include ProvincesHelper

  before(:each) do
    assigns[:province] = @province = stub_model(Province,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit province form" do
    render

    response.should have_tag("form[action=#{province_path(@province)}][method=post]") do
      with_tag('input#province_name[name=?]', "province[name]")
    end
  end
end
