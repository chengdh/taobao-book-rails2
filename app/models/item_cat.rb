class ItemCat < ActiveRecord::Base
  set_primary_key :cid
  #同步商品类目
  def self.synchronize
    sess = Taobao::Session.new
    item_cats = sess.invoke("taobao.itemcats.get","fields" =>"cid,parent_cid,name,is_parent,status,sort_order","parent_cid" => "50005529")
    item_cats.each do |the_item_cat|
      itemcat = ItemCat.new
      Taobao::ItemCat.attr_names.each do |attr| 
        val = the_item_cat.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        itemcat.send("#{attr}=",val)
      end
      itemcat.save
    end
    
  end
end
