class ProvincesController < BaseController
  #根据传入的省份id获取城市列表
  #GET  local_areas/:id/children
  def children
    @province = Province.find(params[:id])
    respond_to do |format|
     format.js {render :partial => "city"}
    end
  end
  # DELETE /provinces/1
  # DELETE /provinces/1.xml
  def destroy
    @province = Province.find(params[:id])
    @province.destroy

    respond_to do |format|
      format.html { redirect_to(provinces_url) }
      format.xml  { head :ok }
    end
  end
end
