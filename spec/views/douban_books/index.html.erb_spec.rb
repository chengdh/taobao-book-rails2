require 'spec_helper'

describe "/douban_books/index.html.erb" do
  include DoubanBooksHelper

  before(:each) do
    assigns[:douban_books] = [
      stub_model(DoubanBook),
      stub_model(DoubanBook)
    ]
  end

  it "renders a list of douban_books" do
    render
  end
end
