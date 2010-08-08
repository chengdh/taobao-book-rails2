require 'spec_helper'

describe ItemPropsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/item_props" }.should route_to(:controller => "item_props", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/item_props/new" }.should route_to(:controller => "item_props", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/item_props/1" }.should route_to(:controller => "item_props", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/item_props/1/edit" }.should route_to(:controller => "item_props", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/item_props" }.should route_to(:controller => "item_props", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/item_props/1" }.should route_to(:controller => "item_props", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/item_props/1" }.should route_to(:controller => "item_props", :action => "destroy", :id => "1") 
    end
  end
end
