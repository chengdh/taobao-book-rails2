module ProvincesHelper
  #省份列表,如果当前用户有位置信息,则设置为默认
  def options_states_for_select
    if default_location.blank?
      options_from_collection_for_select(Province.find(1).children, 'id', 'name')
    else
      selected_state_id = default_location[0].id
      options_from_collection_for_select(Province.find(1).children, 'id', 'name',selected_state_id)
    end
  end
  def default_location
    taobao_sess = session[:taobao_sessioin]
    user = User.find(taobao_sess.top_params[:visitor_id])
    if user.user_location.blank?
      nil
    else
      [Province.name_is(user.user_location.state).first,Province.name_is(user.user_location.city).first]
    end
  end

end
