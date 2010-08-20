require 'spec_helper'

describe "/taobao_books/new.html.erb" do
  include TaobaoBooksHelper

  before(:each) do
    assigns[:taobao_book] = stub_model(TaobaoBook,
      :new_record? => true
    )
  end

  it "renders new taobao_book form" do
    render

    response.should have_tag("form[action=?][method=post]", taobao_books_path) do
    end
  end
end
