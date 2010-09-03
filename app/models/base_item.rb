class BaseItem < ActiveRecord::Base
  set_primary_key :num_iid
  set_table_name "items"
  belongs_to :item_cat,:foreign_key => "cid"
  has_many :item_pvs,:foreign_key => 'num_iid',:dependent => :delete_all,:order => "sort_order,created_at"
  has_many :item_imgs,:foreign_key => "num_iid",:dependent => :delete_all
  #商品所属自定分类信息
  has_many :item_seller_cats,:foreign_key => "num_iid",:dependent => :delete_all
  has_many :seller_cats,:through => :item_seller_cats
  has_many :skus,:foreign_key => :num_iid,:dependent => :delete_all

  #同步单条商品信息
  def self.synchronize_single(sess,num_iid)
    item_fields = Taobao::Item.fields +  ',item_img,sku'
    item = self.new
    item = self.find(num_iid) if self.exists?(num_iid)

    remote_item = sess.invoke("taobao.item.get","fields" => item_fields ,"num_iid" => num_iid).first

    #increment 属性在active_record底层已经定义
    (Taobao::Item.attr_names ).each do |attr|
      val = remote_item.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      if (item.attributes.keys - ['increment','type']).include?("#{attr}") 
        item.send("#{attr}=",val)       
      end
    end
    #type属性是rails 保留属性,因此更名为item_type
    item.state = remote_item.location.state
    item.city = remote_item.location.city
    item.item_type = remote_item.type
    item.id = remote_item.num_iid
    #同步属性信息
    #item.syn_props(sess,remote_item.props)
    item.syn_props_name(remote_item.props_name)
    item.syn_seller_cids(remote_item.seller_cids)
    #同步商品图片信息
    item.syn_item_imgs(remote_item.item_imgs)
    #TODO 同步属性图片信息
    #同步SKU信息
    item.syn_skus(remote_item.skus)
    #TODO 同步Video信息
    item.save
  end

  #同步当前登录用户的在售商品信息
  #需要sessionkey登录验证
  def self.synchronize(sess)
    items = sess.invoke("taobao.items.onsale.get","fields" =>"num_iid,cid",'session' => sess.session_key)
    item_fields = Taobao::Item.fields +  ',item_img,sku'
    items.each do |the_item|
      synchronize_single(sess,the_item.num_iid)
    end
  end
  #得到商品的主图信息,因为如果更新数据到淘宝后,其pic_url会变化
  def self.get_pic_url(sess,num_iid)
    remote_item = sess.invoke("taobao.item.get","fields" => 'iid,num_iid,pic_url' ,"num_iid" => num_iid).first
    remote_item.pic_url
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
      #同步sku properties
      self.skus << item_sku
      item_sku.base_item = self
      item_sku.syn_sku_pvs(sku.properties)
    end
  end
  #同步商品属性值
  #TODO 录入属性使用taobao.itempropvalues.get无法取得
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

      self.item_pvs << item_pv
    end
  end
  #属性props_name
  def syn_props_name(props_name)
    return if props_name.blank? 
    puts props_name
    self.item_pvs.clear
    #生成单个属性数组
    props = props_name.scan(/\d{1,10}:\d{1,10}:[a-zA-Z0-9]*[^\u2E80-\u9FFF]*:[a-zA-Z0-9]*[^\u2E80-\u9FFF]*/)
    puts props
    props.each do |prop|
      puts prop
      #对单个属性字符串进行解析,生成属性数组，顺序为pid,vid,p_name,v_name
      attrs = prop.scan(/[a-zA-Z0-9]*[^\u2E80-\u9FFF]*/)
      #去除空元素
      attrs.delete ""
      item_pv = ItemPv.new
      item_pv.pid = attrs[0]
      item_pv.vid = attrs[1]
      item_pv.prop_name = attrs[2]
      item_pv.name = attrs[3]
      item_pv.name_alias = attrs[3]
      item_pv.is_parent = false
      self.item_pvs << item_pv
    end
  end
  #属性描述
  def item_pvs_desc
    return "" if item_pvs.blank?
    item_pvs.collect {|pv| pv.name}.join('/')
  end
  #将数据更新到淘宝
  #sess top会话对象
  #options 要附加的更新对象
  def save2taobao(sess,options = {})
    updated_values = updated_hash
    #添加session参数
    updated_values["session"] = sess.session_key
    updated_values.merge!(options)

    if self.new_record?
      updated_values.delete(:num_iid)
      updated_values.delete(:iid)
      taobao_method = "taobao.item.add"
    else
      taobao_method = "taobao.item.update"
    end
    remote_item = sess.invoke(taobao_method,updated_values).first
    #重新设置本地taobao对象的pic_url
    pic_url = BaseItem.get_pic_url(sess,remote_item.num_iid)
    self.pic_url = pic_url
    self.id = remote_item.num_iid
    self.iid = remote_item.iid
  end
  #组装props字段
  def props
  end
  #组装input_pids字段
  def input_pids
  end
  #组装input_str字段
  def input_str
  end

  private
  #生成要更新到淘宝的属性hash
  def updated_hash
    updated_values = self.attributes
    #去除是空值的字段
    updated_values.each {|key,value| updated_values.delete(key) if value.blank?}
    #删除不需要更新的字段
    updated_values["type"] = "fixed"
    updated_values["list_time"] = updated_values["list_time"].strftime('%Y-%m-%d %H:%M:%S') unless updated_values["list_time"].blank?
    #updated_values["delist_time"] = updated_values["delist_time"].strftime('%Y-%m-%d %H:%M:%S')
    updated_values["location.state"] = updated_values["state"]
    updated_values["location.city"] = updated_values["city"]
    updated_values["location.state"] = "河南"
    updated_values["location.city"] = "郑州"

    #TODO 暂时注释
    #updated_values["input_pids"] = input_pids
    #updated_values["input_str"] = input_str
    updated_values["props"] = props
    updated_values.delete("item_type")
    updated_values.delete("state")
    updated_values.delete("city")
    updated_values.delete("product_id")
    updated_values.delete("auction_point")
    updated_values.delete("created_at")
    updated_values.delete("updated_at")
    updated_values
  end
end
