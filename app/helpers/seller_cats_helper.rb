module SellerCatsHelper
  #按照店铺分类选择子分类
  def option_groups_seller_cats_for_select(search_param ={})
    search = SellerCat.search(search_param.merge!("shop_nick_is" => session[:taobao_session].top_params["visitor_nick"] ))
    option_groups_from_collection_for_select(search.all,:children,:name,:id,:name)
  end

end
