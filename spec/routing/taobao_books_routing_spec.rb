require 'spec_helper'

describe TaobaoBooksController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/taobao_books" }.should route_to(:controller => "taobao_books", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/taobao_books/new" }.should route_to(:controller => "taobao_books", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/taobao_books/1" }.should route_to(:controller => "taobao_books", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/taobao_books/1/edit" }.should route_to(:controller => "taobao_books", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/taobao_books" }.should route_to(:controller => "taobao_books", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/taobao_books/1" }.should route_to(:controller => "taobao_books", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/taobao_books/1" }.should route_to(:controller => "taobao_books", :action => "destroy", :id => "1") 
    end
  end
end
