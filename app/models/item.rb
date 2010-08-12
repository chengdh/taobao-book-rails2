class Item < ActiveRecord::Base
  set_primary_key :num_iid
  belongs_to :item_cat,:foreign_key => "cid"
  has_many :item_pvs,:foreign_key => 'num_iid',:dependent => :delete_all
  has_many :item_imgs,:foreign_key => "num_iid",:dependent => :delete_all
  #商品所属自定分类信息
  has_many :item_seller_cats,:foreign_key => "num_iid",:dependent => :delete_all
  has_many :seller_cats,:through => :item_seller_cats
  has_many :skus,:foreign_key => :num_iid,:dependent => :delete_all

  #同步当前登录用户的在售商品信息
  #需要sessionkey登录验证
  def self.synchronize(sess)
    items = sess.invoke("taobao.items.onsale.get","fields" =>"num_iid,cid",'session' => sess.session_key)
    item_fields = Taobao::Item.fields +  ',item_img,sku'
    items.each do |the_item|
      item = Item.new
      item = Item.find(the_item.num_iid) if Item.exists?(the_item.num_iid)

      remote_item = sess.invoke("taobao.item.get","fields" => item_fields ,"num_iid" => the_item.num_iid).first

      #increment 属性在active_record底层已经定义
      (Taobao::Item.attr_names ).each do |attr|
        val = remote_item.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        if (item.attributes.keys - ['increment']).include?("#{attr}") 
          item.send("#{attr}=",val)       
        end
      end
      #type属性是rails 保留属性,因此更名为item_type
      item.state = remote_item.location.state
      item.city = remote_item.location.city
      item.item_type = remote_item.type
      item.id = remote_item.num_iid
      #同步属性信息
      item.syn_props(sess,remote_item.props)
      item.syn_seller_cids(remote_item.seller_cids)
      #同步商品图片信息
      item.syn_item_imgs(remote_item.item_imgs)
      #TODO 同步属性图片信息
      #同步SKU信息
      item.syn_skus(remote_item.skus)
      #TODO 同步Video信息
      item.save
    end
  end
  #同步图片信息
  def syn_item_imgs(item_imgs)
    return if item_imgs.blank?
    self.item_imgs.clear
    item_imgs.each do |img|

      item_img = ItemImg.new
      Taobao::ItemImg.attr_names.each {|attr| item_img.send("#{attr}=",img.send("#{attr}")) if item_img.attributes.keys.include?("#{attr}")}
      item_img.img_id = img.id
      self.item_imgs << item_img
    end
  end
  #同步所属分类信息
  def syn_seller_cids(cids)
    return if cids.blank?
    seller_cat_ids = cids.split(',')
    self.item_seller_cats.clear
    seller_cat_ids.each {|sc_id| self.item_seller_cats.build(:cid => sc_id) if !sc_id.blank? }
  end
  #同步sku
  def syn_skus(skus)
   return if skus.blank?
    self.skus.clear
    skus.each do |sku|
      item_sku = Sku.new
      Taobao::Sku.attr_names.each {|attr| item_sku.send("#{attr}=",sku.send("#{attr}")) if item_sku.attributes.keys.include?("#{attr}")}
      item_sku.id = sku.sku_id
      self.skus << item_sku
    end
  end
  #同步商品属性值
  #sess taobao session
  def syn_props(sess,props)
    return if props.blank?
    #FIXME 添加事务处理
    remote_prop_values = sess.invoke("taobao.itempropvalues.get",'cid' => self.cid,'fields' => Taobao::PropValue.fields,'pvs' => props)
    return if remote_prop_values.blank? or remote_prop_values.kind_of? Taobao::ErrorRsp
    #删除原有属性
    self.item_pvs.clear
    remote_prop_values.each do |pv|
      item_pv = ItemPv.new
      Taobao::PropValue.attr_names.each do |attr|
        val = pv.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        item_pv.send("#{attr}=",val) if item_pv.attributes.keys.include?("#{attr}")
      end

      item_pv.num_iid = self.num_iid
      self.item_pvs << item_pv
    end
  end
end
