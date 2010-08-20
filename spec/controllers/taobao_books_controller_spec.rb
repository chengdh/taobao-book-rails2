require 'spec_helper'

describe TaobaoBooksController do

  def mock_taobao_book(stubs={})
    @mock_taobao_book ||= mock_model(TaobaoBook, stubs)
  end

  describe "GET index" do
    it "assigns all taobao_books as @taobao_books" do
      TaobaoBook.stub(:find).with(:all).and_return([mock_taobao_book])
      get :index
      assigns[:taobao_books].should == [mock_taobao_book]
    end
  end

  describe "GET show" do
    it "assigns the requested taobao_book as @taobao_book" do
      TaobaoBook.stub(:find).with("37").and_return(mock_taobao_book)
      get :show, :id => "37"
      assigns[:taobao_book].should equal(mock_taobao_book)
    end
  end

  describe "GET new" do
    it "assigns a new taobao_book as @taobao_book" do
      TaobaoBook.stub(:new).and_return(mock_taobao_book)
      get :new
      assigns[:taobao_book].should equal(mock_taobao_book)
    end
  end

  describe "GET edit" do
    it "assigns the requested taobao_book as @taobao_book" do
      TaobaoBook.stub(:find).with("37").and_return(mock_taobao_book)
      get :edit, :id => "37"
      assigns[:taobao_book].should equal(mock_taobao_book)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created taobao_book as @taobao_book" do
        TaobaoBook.stub(:new).with({'these' => 'params'}).and_return(mock_taobao_book(:save => true))
        post :create, :taobao_book => {:these => 'params'}
        assigns[:taobao_book].should equal(mock_taobao_book)
      end

      it "redirects to the created taobao_book" do
        TaobaoBook.stub(:new).and_return(mock_taobao_book(:save => true))
        post :create, :taobao_book => {}
        response.should redirect_to(taobao_book_url(mock_taobao_book))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved taobao_book as @taobao_book" do
        TaobaoBook.stub(:new).with({'these' => 'params'}).and_return(mock_taobao_book(:save => false))
        post :create, :taobao_book => {:these => 'params'}
        assigns[:taobao_book].should equal(mock_taobao_book)
      end

      it "re-renders the 'new' template" do
        TaobaoBook.stub(:new).and_return(mock_taobao_book(:save => false))
        post :create, :taobao_book => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested taobao_book" do
        TaobaoBook.should_receive(:find).with("37").and_return(mock_taobao_book)
        mock_taobao_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :taobao_book => {:these => 'params'}
      end

      it "assigns the requested taobao_book as @taobao_book" do
        TaobaoBook.stub(:find).and_return(mock_taobao_book(:update_attributes => true))
        put :update, :id => "1"
        assigns[:taobao_book].should equal(mock_taobao_book)
      end

      it "redirects to the taobao_book" do
        TaobaoBook.stub(:find).and_return(mock_taobao_book(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(taobao_book_url(mock_taobao_book))
      end
    end

    describe "with invalid params" do
      it "updates the requested taobao_book" do
        TaobaoBook.should_receive(:find).with("37").and_return(mock_taobao_book)
        mock_taobao_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :taobao_book => {:these => 'params'}
      end

      it "assigns the taobao_book as @taobao_book" do
        TaobaoBook.stub(:find).and_return(mock_taobao_book(:update_attributes => false))
        put :update, :id => "1"
        assigns[:taobao_book].should equal(mock_taobao_book)
      end

      it "re-renders the 'edit' template" do
        TaobaoBook.stub(:find).and_return(mock_taobao_book(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested taobao_book" do
      TaobaoBook.should_receive(:find).with("37").and_return(mock_taobao_book)
      mock_taobao_book.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the taobao_books list" do
      TaobaoBook.stub(:find).and_return(mock_taobao_book(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(taobao_books_url)
    end
  end

end
