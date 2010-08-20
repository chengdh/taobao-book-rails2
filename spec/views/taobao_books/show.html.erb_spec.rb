require 'spec_helper'

describe "/taobao_books/show.html.erb" do
  include TaobaoBooksHelper
  before(:each) do
    assigns[:taobao_book] = @taobao_book = stub_model(TaobaoBook)
  end

  it "renders attributes in <p>" do
    render
  end
end
