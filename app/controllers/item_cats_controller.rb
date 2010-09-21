class ItemCatsController < BaseController
  #GET item_cats/:id/choose_item_cat
  #显示商品类目选择界面
  def children
    @item_cat = ItemCat.find(params[:id])
    render :partial => @item_cat.is_parent ? "item_cat_children" : "select_child.rjs",:locals => {:item_cat => @item_cat}
  end
end
