class PropValuesController < ApplicationController
  # GET /prop_values
  # GET /prop_values.xml
  def index
    @prop_values = PropValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prop_values }
    end
  end

  # GET /prop_values/1
  # GET /prop_values/1.xml
  def show
    @prop_value = PropValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prop_value }
    end
  end

  # GET /prop_values/new
  # GET /prop_values/new.xml
  def new
    @prop_value = PropValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prop_value }
    end
  end

  # GET /prop_values/1/edit
  def edit
    @prop_value = PropValue.find(params[:id])
  end

  # POST /prop_values
  # POST /prop_values.xml
  def create
    @prop_value = PropValue.new(params[:prop_value])

    respond_to do |format|
      if @prop_value.save
        flash[:notice] = 'PropValue was successfully created.'
        format.html { redirect_to(@prop_value) }
        format.xml  { render :xml => @prop_value, :status => :created, :location => @prop_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prop_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prop_values/1
  # PUT /prop_values/1.xml
  def update
    @prop_value = PropValue.find(params[:id])

    respond_to do |format|
      if @prop_value.update_attributes(params[:prop_value])
        flash[:notice] = 'PropValue was successfully updated.'
        format.html { redirect_to(@prop_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prop_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prop_values/1
  # DELETE /prop_values/1.xml
  def destroy
    @prop_value = PropValue.find(params[:id])
    @prop_value.destroy

    respond_to do |format|
      format.html { redirect_to(prop_values_url) }
      format.xml  { head :ok }
    end
  end
end
