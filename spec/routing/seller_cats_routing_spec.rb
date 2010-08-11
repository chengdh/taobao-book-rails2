require 'spec_helper'

describe SellerCatsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/seller_cats" }.should route_to(:controller => "seller_cats", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/seller_cats/new" }.should route_to(:controller => "seller_cats", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/seller_cats/1" }.should route_to(:controller => "seller_cats", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/seller_cats/1/edit" }.should route_to(:controller => "seller_cats", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/seller_cats" }.should route_to(:controller => "seller_cats", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/seller_cats/1" }.should route_to(:controller => "seller_cats", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/seller_cats/1" }.should route_to(:controller => "seller_cats", :action => "destroy", :id => "1") 
    end
  end
end
