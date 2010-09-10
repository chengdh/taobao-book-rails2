require 'spec_helper'

describe "/douban_books/edit.html.erb" do
  include DoubanBooksHelper

  before(:each) do
    assigns[:douban_book] = @douban_book = stub_model(DoubanBook,
      :new_record? => false
    )
  end

  it "renders the edit douban_book form" do
    render

    response.should have_tag("form[action=#{douban_book_path(@douban_book)}][method=post]") do
    end
  end
end
