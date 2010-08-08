require 'spec_helper'

describe PropValuesController do

  def mock_prop_value(stubs={})
    @mock_prop_value ||= mock_model(PropValue, stubs)
  end

  describe "GET index" do
    it "assigns all prop_values as @prop_values" do
      PropValue.stub(:find).with(:all).and_return([mock_prop_value])
      get :index
      assigns[:prop_values].should == [mock_prop_value]
    end
  end

  describe "GET show" do
    it "assigns the requested prop_value as @prop_value" do
      PropValue.stub(:find).with("37").and_return(mock_prop_value)
      get :show, :id => "37"
      assigns[:prop_value].should equal(mock_prop_value)
    end
  end

  describe "GET new" do
    it "assigns a new prop_value as @prop_value" do
      PropValue.stub(:new).and_return(mock_prop_value)
      get :new
      assigns[:prop_value].should equal(mock_prop_value)
    end
  end

  describe "GET edit" do
    it "assigns the requested prop_value as @prop_value" do
      PropValue.stub(:find).with("37").and_return(mock_prop_value)
      get :edit, :id => "37"
      assigns[:prop_value].should equal(mock_prop_value)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created prop_value as @prop_value" do
        PropValue.stub(:new).with({'these' => 'params'}).and_return(mock_prop_value(:save => true))
        post :create, :prop_value => {:these => 'params'}
        assigns[:prop_value].should equal(mock_prop_value)
      end

      it "redirects to the created prop_value" do
        PropValue.stub(:new).and_return(mock_prop_value(:save => true))
        post :create, :prop_value => {}
        response.should redirect_to(prop_value_url(mock_prop_value))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved prop_value as @prop_value" do
        PropValue.stub(:new).with({'these' => 'params'}).and_return(mock_prop_value(:save => false))
        post :create, :prop_value => {:these => 'params'}
        assigns[:prop_value].should equal(mock_prop_value)
      end

      it "re-renders the 'new' template" do
        PropValue.stub(:new).and_return(mock_prop_value(:save => false))
        post :create, :prop_value => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested prop_value" do
        PropValue.should_receive(:find).with("37").and_return(mock_prop_value)
        mock_prop_value.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :prop_value => {:these => 'params'}
      end

      it "assigns the requested prop_value as @prop_value" do
        PropValue.stub(:find).and_return(mock_prop_value(:update_attributes => true))
        put :update, :id => "1"
        assigns[:prop_value].should equal(mock_prop_value)
      end

      it "redirects to the prop_value" do
        PropValue.stub(:find).and_return(mock_prop_value(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(prop_value_url(mock_prop_value))
      end
    end

    describe "with invalid params" do
      it "updates the requested prop_value" do
        PropValue.should_receive(:find).with("37").and_return(mock_prop_value)
        mock_prop_value.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :prop_value => {:these => 'params'}
      end

      it "assigns the prop_value as @prop_value" do
        PropValue.stub(:find).and_return(mock_prop_value(:update_attributes => false))
        put :update, :id => "1"
        assigns[:prop_value].should equal(mock_prop_value)
      end

      it "re-renders the 'edit' template" do
        PropValue.stub(:find).and_return(mock_prop_value(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested prop_value" do
      PropValue.should_receive(:find).with("37").and_return(mock_prop_value)
      mock_prop_value.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the prop_values list" do
      PropValue.stub(:find).and_return(mock_prop_value(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(prop_values_url)
    end
  end

end
