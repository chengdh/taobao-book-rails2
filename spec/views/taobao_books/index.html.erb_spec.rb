require 'spec_helper'

describe "/taobao_books/index.html.erb" do
  include TaobaoBooksHelper

  before(:each) do
    assigns[:taobao_books] = [
      stub_model(TaobaoBook),
      stub_model(TaobaoBook)
    ]
  end

  it "renders a list of taobao_books" do
    render
  end
end
