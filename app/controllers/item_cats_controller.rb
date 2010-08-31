class ItemCatsController < BaseController
  #GET item_cats/:id/choose_item_cat
  #显示商品类目选择界面
  def children
    @item_cat = ItemCat.find(params[:id])
    respond_to do |format|
      format.js {render :partial => "item_cat_children",:locals => {:item_cat => @item_cat}}
    end
  end
end
