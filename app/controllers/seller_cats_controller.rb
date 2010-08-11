class SellerCatsController < ApplicationController
  # GET /seller_cats
  # GET /seller_cats.xml
  def index
    @seller_cats = SellerCat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seller_cats }
    end
  end

  # GET /seller_cats/1
  # GET /seller_cats/1.xml
  def show
    @seller_cat = SellerCat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seller_cat }
    end
  end

  # GET /seller_cats/new
  # GET /seller_cats/new.xml
  def new
    @seller_cat = SellerCat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seller_cat }
    end
  end

  # GET /seller_cats/1/edit
  def edit
    @seller_cat = SellerCat.find(params[:id])
  end

  # POST /seller_cats
  # POST /seller_cats.xml
  def create
    @seller_cat = SellerCat.new(params[:seller_cat])

    respond_to do |format|
      if @seller_cat.save
        flash[:notice] = 'SellerCat was successfully created.'
        format.html { redirect_to(@seller_cat) }
        format.xml  { render :xml => @seller_cat, :status => :created, :location => @seller_cat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seller_cat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seller_cats/1
  # PUT /seller_cats/1.xml
  def update
    @seller_cat = SellerCat.find(params[:id])

    respond_to do |format|
      if @seller_cat.update_attributes(params[:seller_cat])
        flash[:notice] = 'SellerCat was successfully updated.'
        format.html { redirect_to(@seller_cat) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seller_cat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seller_cats/1
  # DELETE /seller_cats/1.xml
  def destroy
    @seller_cat = SellerCat.find(params[:id])
    @seller_cat.destroy

    respond_to do |format|
      format.html { redirect_to(seller_cats_url) }
      format.xml  { head :ok }
    end
  end
end
