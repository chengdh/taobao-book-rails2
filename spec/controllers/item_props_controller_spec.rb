require 'spec_helper'

describe ItemPropsController do

  def mock_item_prop(stubs={})
    @mock_item_prop ||= mock_model(ItemProp, stubs)
  end

  describe "GET index" do
    it "assigns all item_props as @item_props" do
      ItemProp.stub(:find).with(:all).and_return([mock_item_prop])
      get :index
      assigns[:item_props].should == [mock_item_prop]
    end
  end

  describe "GET show" do
    it "assigns the requested item_prop as @item_prop" do
      ItemProp.stub(:find).with("37").and_return(mock_item_prop)
      get :show, :id => "37"
      assigns[:item_prop].should equal(mock_item_prop)
    end
  end

  describe "GET new" do
    it "assigns a new item_prop as @item_prop" do
      ItemProp.stub(:new).and_return(mock_item_prop)
      get :new
      assigns[:item_prop].should equal(mock_item_prop)
    end
  end

  describe "GET edit" do
    it "assigns the requested item_prop as @item_prop" do
      ItemProp.stub(:find).with("37").and_return(mock_item_prop)
      get :edit, :id => "37"
      assigns[:item_prop].should equal(mock_item_prop)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created item_prop as @item_prop" do
        ItemProp.stub(:new).with({'these' => 'params'}).and_return(mock_item_prop(:save => true))
        post :create, :item_prop => {:these => 'params'}
        assigns[:item_prop].should equal(mock_item_prop)
      end

      it "redirects to the created item_prop" do
        ItemProp.stub(:new).and_return(mock_item_prop(:save => true))
        post :create, :item_prop => {}
        response.should redirect_to(item_prop_url(mock_item_prop))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item_prop as @item_prop" do
        ItemProp.stub(:new).with({'these' => 'params'}).and_return(mock_item_prop(:save => false))
        post :create, :item_prop => {:these => 'params'}
        assigns[:item_prop].should equal(mock_item_prop)
      end

      it "re-renders the 'new' template" do
        ItemProp.stub(:new).and_return(mock_item_prop(:save => false))
        post :create, :item_prop => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested item_prop" do
        ItemProp.should_receive(:find).with("37").and_return(mock_item_prop)
        mock_item_prop.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_prop => {:these => 'params'}
      end

      it "assigns the requested item_prop as @item_prop" do
        ItemProp.stub(:find).and_return(mock_item_prop(:update_attributes => true))
        put :update, :id => "1"
        assigns[:item_prop].should equal(mock_item_prop)
      end

      it "redirects to the item_prop" do
        ItemProp.stub(:find).and_return(mock_item_prop(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(item_prop_url(mock_item_prop))
      end
    end

    describe "with invalid params" do
      it "updates the requested item_prop" do
        ItemProp.should_receive(:find).with("37").and_return(mock_item_prop)
        mock_item_prop.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_prop => {:these => 'params'}
      end

      it "assigns the item_prop as @item_prop" do
        ItemProp.stub(:find).and_return(mock_item_prop(:update_attributes => false))
        put :update, :id => "1"
        assigns[:item_prop].should equal(mock_item_prop)
      end

      it "re-renders the 'edit' template" do
        ItemProp.stub(:find).and_return(mock_item_prop(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested item_prop" do
      ItemProp.should_receive(:find).with("37").and_return(mock_item_prop)
      mock_item_prop.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the item_props list" do
      ItemProp.stub(:find).and_return(mock_item_prop(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(item_props_url)
    end
  end

end
