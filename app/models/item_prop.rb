class ItemProp < ActiveRecord::Base
  set_primary_key :pid
  belongs_to :item_cat,:foreign_key => "cid"
  has_many :prop_values,:foreign_key => "pid",:order => 'sort_order'
  acts_as_tree :foreign_key => "parent_pid",:order => "sort_order"

  #TODO 设置父属性值关联

  #同步商品属性类目
  #c_id 商品类目id
  #sess taobao session
  def self.synchronize(sess,c_id)
    #FIXME 添加事务处理

    remote_item_props = sess.invoke("taobao.itemprops.get",'fields' => Taobao::ItemProp.fields,"cid" => c_id)
    return if remote_item_props.blank? 
    remote_item_props.each do |the_item_prop|
      item_prop = ItemProp.new
      item_prop = ItemProp.find(the_item_prop.pid) if ItemProp.exists?(the_item_prop.pid)
      Taobao::ItemProp.attr_names.each do |attr|
        val = the_item_prop.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        item_prop.send("#{attr}=",val) if (item_prop.attributes.keys - ["pid"]).include?("#{attr}")
        item_prop.cid = c_id
      end
      item_prop.id = the_item_prop.pid
      item_prop.save
    end
  end
  #设置需要特殊处理的属性
  def prop_values
  end
  def prop_values=(prop_values)
  end
end
