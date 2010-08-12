require 'spec_helper'

describe PostagesController do

  def mock_postage(stubs={})
    @mock_postage ||= mock_model(Postage, stubs)
  end

  describe "GET index" do
    it "assigns all postages as @postages" do
      Postage.stub(:find).with(:all).and_return([mock_postage])
      get :index
      assigns[:postages].should == [mock_postage]
    end
  end

  describe "GET show" do
    it "assigns the requested postage as @postage" do
      Postage.stub(:find).with("37").and_return(mock_postage)
      get :show, :id => "37"
      assigns[:postage].should equal(mock_postage)
    end
  end

  describe "GET new" do
    it "assigns a new postage as @postage" do
      Postage.stub(:new).and_return(mock_postage)
      get :new
      assigns[:postage].should equal(mock_postage)
    end
  end

  describe "GET edit" do
    it "assigns the requested postage as @postage" do
      Postage.stub(:find).with("37").and_return(mock_postage)
      get :edit, :id => "37"
      assigns[:postage].should equal(mock_postage)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created postage as @postage" do
        Postage.stub(:new).with({'these' => 'params'}).and_return(mock_postage(:save => true))
        post :create, :postage => {:these => 'params'}
        assigns[:postage].should equal(mock_postage)
      end

      it "redirects to the created postage" do
        Postage.stub(:new).and_return(mock_postage(:save => true))
        post :create, :postage => {}
        response.should redirect_to(postage_url(mock_postage))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved postage as @postage" do
        Postage.stub(:new).with({'these' => 'params'}).and_return(mock_postage(:save => false))
        post :create, :postage => {:these => 'params'}
        assigns[:postage].should equal(mock_postage)
      end

      it "re-renders the 'new' template" do
        Postage.stub(:new).and_return(mock_postage(:save => false))
        post :create, :postage => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested postage" do
        Postage.should_receive(:find).with("37").and_return(mock_postage)
        mock_postage.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :postage => {:these => 'params'}
      end

      it "assigns the requested postage as @postage" do
        Postage.stub(:find).and_return(mock_postage(:update_attributes => true))
        put :update, :id => "1"
        assigns[:postage].should equal(mock_postage)
      end

      it "redirects to the postage" do
        Postage.stub(:find).and_return(mock_postage(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(postage_url(mock_postage))
      end
    end

    describe "with invalid params" do
      it "updates the requested postage" do
        Postage.should_receive(:find).with("37").and_return(mock_postage)
        mock_postage.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :postage => {:these => 'params'}
      end

      it "assigns the postage as @postage" do
        Postage.stub(:find).and_return(mock_postage(:update_attributes => false))
        put :update, :id => "1"
        assigns[:postage].should equal(mock_postage)
      end

      it "re-renders the 'edit' template" do
        Postage.stub(:find).and_return(mock_postage(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested postage" do
      Postage.should_receive(:find).with("37").and_return(mock_postage)
      mock_postage.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the postages list" do
      Postage.stub(:find).and_return(mock_postage(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(postages_url)
    end
  end

end
