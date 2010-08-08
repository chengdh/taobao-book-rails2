class ItemCat < ActiveRecord::Base
  set_primary_key :cid
  acts_as_tree :foreign_key => "parent_cid",:order => "sort_order"
  #同步商品类目
  #FIXME 添加事务处理
  def self.synchronize(sess)
    item_cats = sess.invoke("taobao.itemcats.get","fields" =>Taobao::ItemCat.fields,"datetime" => "2001-01-01 00:00:00")
    item_cats.each do |the_item_cat|
      return if the_item_cat.cid.blank?
      itemcat = ItemCat.new 
      itemcat = ItemCat.find(the_item_cat.cid) if ItemCat.exists?(the_item_cat.cid)
      Taobao::ItemCat.attr_names.each do |attr| 
        val = the_item_cat.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        itemcat.send("#{attr}=",val)
      end
      itemcat.save
      #同步item_prop
      ItemProp.synchronize(sess,itemcat.cid) if !itemcat.is_parent
      #同步prop_value
      PropValue.synchronize(sess,itemcat.cid) if !itemcat.is_parent
    end
  end
end
