require 'spec_helper'

describe "/taobao_books/edit.html.erb" do
  include TaobaoBooksHelper

  before(:each) do
    assigns[:taobao_book] = @taobao_book = stub_model(TaobaoBook,
      :new_record? => false
    )
  end

  it "renders the edit taobao_book form" do
    render

    response.should have_tag("form[action=#{taobao_book_path(@taobao_book)}][method=post]") do
    end
  end
end
