class LocalArea < ActiveRecord::Base
  acts_as_tree :foreign_key => "parent_id"
  #从淘宝同步
  def self.synchronize(sess)
    areas = sess.invoke("taobao.areas.get","fields" =>Taobao::Area.fields)
    areas.each do |remote_area|
      area = LocalArea.new 
      area = LocalArea.find(remote_area.id) if LocalArea.exists?(remote_area.id)
      Taobao::Area.attr_names.each do |attr| 
        val = remote_area.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        area.send("#{attr}=",val) if (area.attributes.keys).include?("#{attr}")
      end
      area.area_type = remote_area.type
      area.id = remote_area.id
      area.save
    end
  end
end
