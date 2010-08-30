class LocalAreasController < BaseController
  #根据传入的省份id获取城市列表
  #GET  local_areas/:id/children
  def children
    @local_area = LocalArea.find(params[:id])
    respond_to do |format|
     format.js {render :partial => "cities"}
    end
  end
end
