class PropValue < ActiveRecord::Base
  set_primary_key :vid
  belongs_to :item_cat,:foreign_key => "cid"
  belongs_to :item_prop,:foreign_key => 'pid'


  #同步商品属性值
  #c_id 商品类目id
  #sess taobao session
  def self.synchronize(sess,other_options = {})
    #FIXME 添加事务处理

    remote_prop_values = sess.invoke("taobao.itempropvalues.get",other_options)

    return if remote_prop_values.blank? 
    remote_prop_values.each do |pv|
      prop_value = PropValue.new
      prop_value = PropValue.find(pv.vid) if PropValue.exists?(pv.vid)
      Taobao::PropValue.attr_names.each do |attr|
        val = pv.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        prop_value.send("#{attr}=",val) if (prop_value.attributes.keys - ["vid"]).include?("#{attr}")
      end
      prop_value.id = pv.vid
      prop_value.save
    end
  end
end
