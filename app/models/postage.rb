class Postage < ActiveRecord::Base
  set_primary_key :postage_id
  has_many :postage_modes
  #同步当前登录用户邮费模板
  #要求用户必须登录
  def self.synchronize(sess)
    fields = Taobao::Postage.fields + ",postage_mode"
    nick = sess.top_params["visitor_nick"]
    postages = sess.invoke("taobao.postages.get","fields" => fields,'session' => sess.session_key)
    postages.each do |remote_p|
      postage = Postage.new
      postage = Postage.find(remote_p.postage_id) if Postage.exists?(remote_p.postage_id)

      (Taobao::Postage.attr_names ).each do |attr|
        val = remote_p.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        if (postage.attributes.keys).include?("#{attr}") 
          postage.send("#{attr}=",val)       
        end
      end
      postage.nick = nick
      postage.id = remote_p.postage_id
      postage.syn_postage_mode(remote_p.postage_modes)
      postage.save
    end
  end
  #同步子运费模板
  def syn_postage_mode(p_ms)
    return if p_ms.blank?
    self.postage_modes.clear
    p_ms.each do |pm|
      postage_mode = PostageMode.new
      Taobao::PostageMode.attr_names.each do |attr|
        val = pm.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        postage_mode.send("#{attr}=",val) if postage_mode.attributes.keys.include?("#{attr}")
      end
      self.postage_modes << postage_mode
    end
  end
end
