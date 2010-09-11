module PostagesHelper
  def options_postages_for_select()
    options_from_collection_for_select(Postage.nick_is(session[:taobao_session].top_params["visitor_nick"]), 'id', 'name')
  end
end
