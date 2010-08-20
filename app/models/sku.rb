class Sku < ActiveRecord::Base
  set_primary_key :sku_id
  belongs_to :base_item,:foreign_key => :num_iid
  has_many :sku_pvs,:foreign_key => :sku_id,:dependent => :delete_all

  def syn_sku_pvs(pvs)
    puts self.item
    return if pvs.blank?
    sess = Taobao::Session.new
    remote_prop_values = sess.invoke("taobao.itempropvalues.get",'cid' => self.item.cid,'fields' => Taobao::PropValue.fields,'pvs' => pvs)
    return if remote_prop_values.blank? or remote_prop_values.kind_of? Taobao::ErrorRsp
    #删除原有属性
    self.sku_pvs.clear
    remote_prop_values.each do |pv|
      sku_pv = SkuPv.new
      Taobao::PropValue.attr_names.each do |attr|
        val = pv.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        sku_pv.send("#{attr}=",val) if sku_pv.attributes.keys.include?("#{attr}")
      end

      sku_pv.sku_id = self.id
      self.sku_pvs << sku_pv
    end
  end
end
