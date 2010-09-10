require 'spec_helper'

describe "/douban_books/show.html.erb" do
  include DoubanBooksHelper
  before(:each) do
    assigns[:douban_book] = @douban_book = stub_model(DoubanBook)
  end

  it "renders attributes in <p>" do
    render
  end
end
