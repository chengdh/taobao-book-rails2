require 'spec_helper'

describe DoubanBooksController do

  def mock_douban_book(stubs={})
    @mock_douban_book ||= mock_model(DoubanBook, stubs)
  end

  describe "GET index" do
    it "assigns all douban_books as @douban_books" do
      DoubanBook.stub(:find).with(:all).and_return([mock_douban_book])
      get :index
      assigns[:douban_books].should == [mock_douban_book]
    end
  end

  describe "GET show" do
    it "assigns the requested douban_book as @douban_book" do
      DoubanBook.stub(:find).with("37").and_return(mock_douban_book)
      get :show, :id => "37"
      assigns[:douban_book].should equal(mock_douban_book)
    end
  end

  describe "GET new" do
    it "assigns a new douban_book as @douban_book" do
      DoubanBook.stub(:new).and_return(mock_douban_book)
      get :new
      assigns[:douban_book].should equal(mock_douban_book)
    end
  end

  describe "GET edit" do
    it "assigns the requested douban_book as @douban_book" do
      DoubanBook.stub(:find).with("37").and_return(mock_douban_book)
      get :edit, :id => "37"
      assigns[:douban_book].should equal(mock_douban_book)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created douban_book as @douban_book" do
        DoubanBook.stub(:new).with({'these' => 'params'}).and_return(mock_douban_book(:save => true))
        post :create, :douban_book => {:these => 'params'}
        assigns[:douban_book].should equal(mock_douban_book)
      end

      it "redirects to the created douban_book" do
        DoubanBook.stub(:new).and_return(mock_douban_book(:save => true))
        post :create, :douban_book => {}
        response.should redirect_to(douban_book_url(mock_douban_book))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved douban_book as @douban_book" do
        DoubanBook.stub(:new).with({'these' => 'params'}).and_return(mock_douban_book(:save => false))
        post :create, :douban_book => {:these => 'params'}
        assigns[:douban_book].should equal(mock_douban_book)
      end

      it "re-renders the 'new' template" do
        DoubanBook.stub(:new).and_return(mock_douban_book(:save => false))
        post :create, :douban_book => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested douban_book" do
        DoubanBook.should_receive(:find).with("37").and_return(mock_douban_book)
        mock_douban_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :douban_book => {:these => 'params'}
      end

      it "assigns the requested douban_book as @douban_book" do
        DoubanBook.stub(:find).and_return(mock_douban_book(:update_attributes => true))
        put :update, :id => "1"
        assigns[:douban_book].should equal(mock_douban_book)
      end

      it "redirects to the douban_book" do
        DoubanBook.stub(:find).and_return(mock_douban_book(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(douban_book_url(mock_douban_book))
      end
    end

    describe "with invalid params" do
      it "updates the requested douban_book" do
        DoubanBook.should_receive(:find).with("37").and_return(mock_douban_book)
        mock_douban_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :douban_book => {:these => 'params'}
      end

      it "assigns the douban_book as @douban_book" do
        DoubanBook.stub(:find).and_return(mock_douban_book(:update_attributes => false))
        put :update, :id => "1"
        assigns[:douban_book].should equal(mock_douban_book)
      end

      it "re-renders the 'edit' template" do
        DoubanBook.stub(:find).and_return(mock_douban_book(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested douban_book" do
      DoubanBook.should_receive(:find).with("37").and_return(mock_douban_book)
      mock_douban_book.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the douban_books list" do
      DoubanBook.stub(:find).and_return(mock_douban_book(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(douban_books_url)
    end
  end

end
