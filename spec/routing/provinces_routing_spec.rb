require 'spec_helper'

describe ProvincesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/provinces" }.should route_to(:controller => "provinces", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/provinces/new" }.should route_to(:controller => "provinces", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/provinces/1" }.should route_to(:controller => "provinces", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/provinces/1/edit" }.should route_to(:controller => "provinces", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/provinces" }.should route_to(:controller => "provinces", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/provinces/1" }.should route_to(:controller => "provinces", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/provinces/1" }.should route_to(:controller => "provinces", :action => "destroy", :id => "1") 
    end
  end
end
