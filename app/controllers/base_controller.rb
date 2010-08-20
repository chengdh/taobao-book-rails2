#controller 基础类
class BaseController < ApplicationController
  before_filter :model_klazz,:create_search
  # GET /the_models
  # GET /the_models.xml
  def index
    the_models = @search.paginate :page => params[:page],:order => "created_at DESC"

    instance_variable_set("@#{@param_name.tableize}",the_models)
    respond_to do |format|
      format.html { render :template => params[:template] if !params[:template].blank? }# index.html.erb
      format.xml  { render :xml => the_models }
    end
  end

  # GET /the_models/1
  # GET /the_models/1.xml
  def show
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => the_model }
    end
  end

  # GET /the_models/new
  # GET /the_models/new.xml
  def new
    the_model = @model_klazz.new

    instance_variable_set("@#{@param_name}",the_model)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => the_model }
    end
  end

  # GET /the_models/1/edit
  def edit
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)
  end

  # POST /the_models
  # POST /the_models.xml
  def create
    the_model = @model_klazz.new(params[@param_name])

    instance_variable_set("@#{@param_name}",the_model)
    respond_to do |format|
      if the_model.save
        flash[:notice] = "#{@model_klazz.human_name} 保存成功."
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => the_model, :status => :created, :location => the_model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => the_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /the_models/1
  # PUT /the_models/1.xml
  def update
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)
    respond_to do |format|
      if the_model.update_attributes(params[@param_name])
        flash[:notice] = "#{@model_klazz.human_name} 更新成功."
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => the_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /the_models/1
  # DELETE /the_models/1.xml
  def destroy
    the_model = @model_klazz.find(params[:id])
    the_model.destroy

    flash[:notice] = "#{@model_klazz.human_name} 已被删除."
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  protected
  #根据请求的url名称得到该controller对应的model类名和参数名
  def model_klazz
    #注: controller_name 返回形式为复数 例如Bills/Confirms
    @model_klazz = controller_name.classify.constantize
    @param_name = controller_name.singularize.downcase
  end
  #生成@search对象
  def create_search
    @search = @model_klazz.search(params[:search])
  end
end
