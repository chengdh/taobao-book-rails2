require 'spec_helper'

describe "/areas/new.html.erb" do
  include AreasHelper

  before(:each) do
    assigns[:area] = stub_model(Area,
      :new_record? => true,
      :id => 1,
      :area_type => 1,
      :name => "value for name",
      :parent_id => 1,
      :zip => "value for zip"
    )
  end

  it "renders new area form" do
    render

    response.should have_tag("form[action=?][method=post]", areas_path) do
      with_tag("input#area_id[name=?]", "area[id]")
      with_tag("input#area_area_type[name=?]", "area[area_type]")
      with_tag("input#area_name[name=?]", "area[name]")
      with_tag("input#area_parent_id[name=?]", "area[parent_id]")
      with_tag("input#area_zip[name=?]", "area[zip]")
    end
  end
end
