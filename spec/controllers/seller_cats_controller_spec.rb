require 'spec_helper'

describe SellerCatsController do

  def mock_seller_cat(stubs={})
    @mock_seller_cat ||= mock_model(SellerCat, stubs)
  end

  describe "GET index" do
    it "assigns all seller_cats as @seller_cats" do
      SellerCat.stub(:find).with(:all).and_return([mock_seller_cat])
      get :index
      assigns[:seller_cats].should == [mock_seller_cat]
    end
  end

  describe "GET show" do
    it "assigns the requested seller_cat as @seller_cat" do
      SellerCat.stub(:find).with("37").and_return(mock_seller_cat)
      get :show, :id => "37"
      assigns[:seller_cat].should equal(mock_seller_cat)
    end
  end

  describe "GET new" do
    it "assigns a new seller_cat as @seller_cat" do
      SellerCat.stub(:new).and_return(mock_seller_cat)
      get :new
      assigns[:seller_cat].should equal(mock_seller_cat)
    end
  end

  describe "GET edit" do
    it "assigns the requested seller_cat as @seller_cat" do
      SellerCat.stub(:find).with("37").and_return(mock_seller_cat)
      get :edit, :id => "37"
      assigns[:seller_cat].should equal(mock_seller_cat)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created seller_cat as @seller_cat" do
        SellerCat.stub(:new).with({'these' => 'params'}).and_return(mock_seller_cat(:save => true))
        post :create, :seller_cat => {:these => 'params'}
        assigns[:seller_cat].should equal(mock_seller_cat)
      end

      it "redirects to the created seller_cat" do
        SellerCat.stub(:new).and_return(mock_seller_cat(:save => true))
        post :create, :seller_cat => {}
        response.should redirect_to(seller_cat_url(mock_seller_cat))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved seller_cat as @seller_cat" do
        SellerCat.stub(:new).with({'these' => 'params'}).and_return(mock_seller_cat(:save => false))
        post :create, :seller_cat => {:these => 'params'}
        assigns[:seller_cat].should equal(mock_seller_cat)
      end

      it "re-renders the 'new' template" do
        SellerCat.stub(:new).and_return(mock_seller_cat(:save => false))
        post :create, :seller_cat => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested seller_cat" do
        SellerCat.should_receive(:find).with("37").and_return(mock_seller_cat)
        mock_seller_cat.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :seller_cat => {:these => 'params'}
      end

      it "assigns the requested seller_cat as @seller_cat" do
        SellerCat.stub(:find).and_return(mock_seller_cat(:update_attributes => true))
        put :update, :id => "1"
        assigns[:seller_cat].should equal(mock_seller_cat)
      end

      it "redirects to the seller_cat" do
        SellerCat.stub(:find).and_return(mock_seller_cat(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(seller_cat_url(mock_seller_cat))
      end
    end

    describe "with invalid params" do
      it "updates the requested seller_cat" do
        SellerCat.should_receive(:find).with("37").and_return(mock_seller_cat)
        mock_seller_cat.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :seller_cat => {:these => 'params'}
      end

      it "assigns the seller_cat as @seller_cat" do
        SellerCat.stub(:find).and_return(mock_seller_cat(:update_attributes => false))
        put :update, :id => "1"
        assigns[:seller_cat].should equal(mock_seller_cat)
      end

      it "re-renders the 'edit' template" do
        SellerCat.stub(:find).and_return(mock_seller_cat(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested seller_cat" do
      SellerCat.should_receive(:find).with("37").and_return(mock_seller_cat)
      mock_seller_cat.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the seller_cats list" do
      SellerCat.stub(:find).and_return(mock_seller_cat(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(seller_cats_url)
    end
  end

end
