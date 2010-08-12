require 'spec_helper'

describe PostagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/postages" }.should route_to(:controller => "postages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/postages/new" }.should route_to(:controller => "postages", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/postages/1" }.should route_to(:controller => "postages", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/postages/1/edit" }.should route_to(:controller => "postages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/postages" }.should route_to(:controller => "postages", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/postages/1" }.should route_to(:controller => "postages", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/postages/1" }.should route_to(:controller => "postages", :action => "destroy", :id => "1") 
    end
  end
end
