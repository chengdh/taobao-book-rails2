class Item < ActiveRecord::Base
  set_primary_key :num_iid
  belongs_to :item_cat,:foreign_key => "cid"
  has_many :item_pvs,:foreign_key => 'num_iid'

  #同步当前登录用户的在售商品信息
  #需要sessionkey登录验证
  def self.synchronize(sess)
    items = sess.invoke("taobao.items.onsale.get","fields" =>"num_iid,cid",'session' => sess.session_key)
    item_fields = Taobao::Item.fields
    items.each do |the_item|
      item = Item.new
      item = Item.find(the_item.num_iid) if Item.exists?(the_item.num_iid)

      remote_item = sess.invoke("taobao.item.get","fields" => item_fields,"num_iid" => the_item.num_iid).first

      #increment 属性在active_record底层已经定义
      (Taobao::Item.attr_names ).each do |attr|
        val = remote_item.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        if (item.attributes.keys - ['increment']).include?("#{attr}") or item.methods.include?("#{attr}=")
          item.send("#{attr}=",val)       
        end
      end
      #type属性是rails 保留属性,因此更名为item_type
      item.item_type = remote_item.type
      item.id = remote_item.num_iid
      item.save
    end
  end
  #以下定义一些需要处理的属性
  def input_pids
  end
  def input_pids=(pids)
  end
  def input_str
  end
  def input_str=(str)
  end
  def seller_cids
  end
  def seller_cids=(seller_cids)
  end
  def props
  end
  #同步商品属性信息
  def props=(props)
    if !props.blank?
      sess = Taobao::Session.new
      syn_props(sess,'cid' => self.cid,'fields' => Taobao::PropValue.fields,'pvs' => props)
    end
  end
  def property_alias
  end
  def property_alias=(p_alias)
  end
  def location
  end
  def location=(loc)
  end
  private
  #同步商品属性值
  #sess taobao session
  def syn_props(sess,options = {})
    #FIXME 添加事务处理
    remote_prop_values = sess.invoke("taobao.itempropvalues.get",options)
    return if remote_prop_values.blank? or remote_prop_values.kind_of? Taobao::ErrorRsp
    #删除原有属性
    ItemPv.destroy_all(:num_iid => self.num_iid)
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
      item_pv.save
    end
  end
end
