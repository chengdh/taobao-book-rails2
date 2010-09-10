require 'spec_helper'

describe "/douban_books/new.html.erb" do
  include DoubanBooksHelper

  before(:each) do
    assigns[:douban_book] = stub_model(DoubanBook,
      :new_record? => true
    )
  end

  it "renders new douban_book form" do
    render

    response.should have_tag("form[action=?][method=post]", douban_books_path) do
    end
  end
end
