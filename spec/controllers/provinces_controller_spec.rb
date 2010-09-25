require 'spec_helper'

describe ProvincesController do

  def mock_province(stubs={})
    @mock_province ||= mock_model(Province, stubs)
  end

  describe "GET index" do
    it "assigns all provinces as @provinces" do
      Province.stub(:find).with(:all).and_return([mock_province])
      get :index
      assigns[:provinces].should == [mock_province]
    end
  end

  describe "GET show" do
    it "assigns the requested province as @province" do
      Province.stub(:find).with("37").and_return(mock_province)
      get :show, :id => "37"
      assigns[:province].should equal(mock_province)
    end
  end

  describe "GET new" do
    it "assigns a new province as @province" do
      Province.stub(:new).and_return(mock_province)
      get :new
      assigns[:province].should equal(mock_province)
    end
  end

  describe "GET edit" do
    it "assigns the requested province as @province" do
      Province.stub(:find).with("37").and_return(mock_province)
      get :edit, :id => "37"
      assigns[:province].should equal(mock_province)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created province as @province" do
        Province.stub(:new).with({'these' => 'params'}).and_return(mock_province(:save => true))
        post :create, :province => {:these => 'params'}
        assigns[:province].should equal(mock_province)
      end

      it "redirects to the created province" do
        Province.stub(:new).and_return(mock_province(:save => true))
        post :create, :province => {}
        response.should redirect_to(province_url(mock_province))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved province as @province" do
        Province.stub(:new).with({'these' => 'params'}).and_return(mock_province(:save => false))
        post :create, :province => {:these => 'params'}
        assigns[:province].should equal(mock_province)
      end

      it "re-renders the 'new' template" do
        Province.stub(:new).and_return(mock_province(:save => false))
        post :create, :province => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested province" do
        Province.should_receive(:find).with("37").and_return(mock_province)
        mock_province.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :province => {:these => 'params'}
      end

      it "assigns the requested province as @province" do
        Province.stub(:find).and_return(mock_province(:update_attributes => true))
        put :update, :id => "1"
        assigns[:province].should equal(mock_province)
      end

      it "redirects to the province" do
        Province.stub(:find).and_return(mock_province(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(province_url(mock_province))
      end
    end

    describe "with invalid params" do
      it "updates the requested province" do
        Province.should_receive(:find).with("37").and_return(mock_province)
        mock_province.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :province => {:these => 'params'}
      end

      it "assigns the province as @province" do
        Province.stub(:find).and_return(mock_province(:update_attributes => false))
        put :update, :id => "1"
        assigns[:province].should equal(mock_province)
      end

      it "re-renders the 'edit' template" do
        Province.stub(:find).and_return(mock_province(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested province" do
      Province.should_receive(:find).with("37").and_return(mock_province)
      mock_province.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the provinces list" do
      Province.stub(:find).and_return(mock_province(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(provinces_url)
    end
  end

end
