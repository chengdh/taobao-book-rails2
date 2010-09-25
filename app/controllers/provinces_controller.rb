class ProvincesController < BaseController
  #根据传入的省份id获取城市列表
  #GET  local_areas/:id/children
  def children
    @province = Province.find(params[:id])
    respond_to do |format|
     format.js {render :partial => "city"}
    end
  end
end
