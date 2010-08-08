class ItemPropsController < ApplicationController
  # GET /item_props
  # GET /item_props.xml
  def index
    @item_props = ItemProp.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @item_props }
    end
  end

  # GET /item_props/1
  # GET /item_props/1.xml
  def show
    @item_prop = ItemProp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_prop }
    end
  end

  # GET /item_props/new
  # GET /item_props/new.xml
  def new
    @item_prop = ItemProp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_prop }
    end
  end

  # GET /item_props/1/edit
  def edit
    @item_prop = ItemProp.find(params[:id])
  end

  # POST /item_props
  # POST /item_props.xml
  def create
    @item_prop = ItemProp.new(params[:item_prop])

    respond_to do |format|
      if @item_prop.save
        flash[:notice] = 'ItemProp was successfully created.'
        format.html { redirect_to(@item_prop) }
        format.xml  { render :xml => @item_prop, :status => :created, :location => @item_prop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_prop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /item_props/1
  # PUT /item_props/1.xml
  def update
    @item_prop = ItemProp.find(params[:id])

    respond_to do |format|
      if @item_prop.update_attributes(params[:item_prop])
        flash[:notice] = 'ItemProp was successfully updated.'
        format.html { redirect_to(@item_prop) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_prop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /item_props/1
  # DELETE /item_props/1.xml
  def destroy
    @item_prop = ItemProp.find(params[:id])
    @item_prop.destroy

    respond_to do |format|
      format.html { redirect_to(item_props_url) }
      format.xml  { head :ok }
    end
  end
end
