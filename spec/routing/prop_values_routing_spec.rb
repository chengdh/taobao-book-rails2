require 'spec_helper'

describe PropValuesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/prop_values" }.should route_to(:controller => "prop_values", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/prop_values/new" }.should route_to(:controller => "prop_values", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/prop_values/1" }.should route_to(:controller => "prop_values", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/prop_values/1/edit" }.should route_to(:controller => "prop_values", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/prop_values" }.should route_to(:controller => "prop_values", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/prop_values/1" }.should route_to(:controller => "prop_values", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/prop_values/1" }.should route_to(:controller => "prop_values", :action => "destroy", :id => "1") 
    end
  end
end
