class Item < ActiveRecord::Base
  set_primary_key :num_iid
  belongs_to :item_cat,:foreign_key => "c_id"

  #同步给定用户的商品信息
  def self.synchronize(sess,nick)
    items = sess.invoke("taobao.items.get","fields" =>"num_iid","nicks" => nick)
    item_fields = Taobao::Item.fields(:exclude => ['increment'])
    items.each do |the_item|
      the_item = sess.invoke("taobao.item.get","fields" => item_fields,"num_iid" => the_item.num_iid).first
      item = Item.new
      item = Item.find(the_item.num_iid) if Item.exists?(the_item.num_iid)
      #increment 属性在active_record底层已经定义
      (Taobao::Item.attr_names - [:increment]).each do |attr|
        val = the_item.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        item.send("#{attr}=",val)
      end
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
  def props=(props)
  end
  def property_alias
  end
  def property_alias=(p_alias)
  end
  def location
  end
  def location=(l)
  end
end
