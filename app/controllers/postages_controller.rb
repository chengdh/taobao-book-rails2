class PostagesController < ApplicationController
  # GET /postages
  # GET /postages.xml
  def index
    @postages = Postage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @postages }
    end
  end

  # GET /postages/1
  # GET /postages/1.xml
  def show
    @postage = Postage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @postage }
    end
  end

  # GET /postages/new
  # GET /postages/new.xml
  def new
    @postage = Postage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @postage }
    end
  end

  # GET /postages/1/edit
  def edit
    @postage = Postage.find(params[:id])
  end

  # POST /postages
  # POST /postages.xml
  def create
    @postage = Postage.new(params[:postage])

    respond_to do |format|
      if @postage.save
        flash[:notice] = 'Postage was successfully created.'
        format.html { redirect_to(@postage) }
        format.xml  { render :xml => @postage, :status => :created, :location => @postage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @postage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /postages/1
  # PUT /postages/1.xml
  def update
    @postage = Postage.find(params[:id])

    respond_to do |format|
      if @postage.update_attributes(params[:postage])
        flash[:notice] = 'Postage was successfully updated.'
        format.html { redirect_to(@postage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @postage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /postages/1
  # DELETE /postages/1.xml
  def destroy
    @postage = Postage.find(params[:id])
    @postage.destroy

    respond_to do |format|
      format.html { redirect_to(postages_url) }
      format.xml  { head :ok }
    end
  end
end
