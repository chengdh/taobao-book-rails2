require 'spec_helper'

describe DoubanBooksController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/douban_books" }.should route_to(:controller => "douban_books", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/douban_books/new" }.should route_to(:controller => "douban_books", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/douban_books/1" }.should route_to(:controller => "douban_books", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/douban_books/1/edit" }.should route_to(:controller => "douban_books", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/douban_books" }.should route_to(:controller => "douban_books", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/douban_books/1" }.should route_to(:controller => "douban_books", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/douban_books/1" }.should route_to(:controller => "douban_books", :action => "destroy", :id => "1") 
    end
  end
end
