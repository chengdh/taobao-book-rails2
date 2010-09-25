class User < ActiveRecord::Base
  set_primary_key :user_id
  belongs_to :user_location,:foreign_key => "location_id",:autosave => true
  belongs_to :buyer_credit,:class_name => "UserCredit",:foreign_key => "buyer_credit_id"
  belongs_to :seller_credit,:class_name => "UserCredit",:foreign_key => "seller_credit_id"
  #同步当前会话用户信息
  def self.synchronize(sess)
    fields = Taobao::User.fields
    nick = sess.top_params['visitor_nick']
    user = self.new
    user = self.find(sess.top_params["visitor_id"]) if self.exists?(sess.top_params["visitor_id"])

    remote_user = sess.invoke("taobao.user.get","fields" =>fields,'nick' => nick,'session' => sess.session_key).first
    (Taobao::User.attr_names ).each do |attr|
      val = remote_user.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      if (user.attributes.keys).include?("#{attr}") 
        user.send("#{attr}=",val)       
      end
    end
    user.id = remote_user.user_id
    user.user_type = remote_user.type
    #同步location
    user.user_location.destroy unless user.user_location.blank?
    user.syn_location(remote_user.location)
    #同步buyer_credit及seller_credit
    user.buyer_credit.destroy unless user.buyer_credit.blank?
    user.seller_credit.destroy unless user.seller_credit.blank?
    user.buyer_credit = user.syn_credit(remote_user.buyer_credit)
    user.seller_credit = user.syn_credit(remote_user.seller_credit)
    user.save
  end
  #同步location
  def syn_location(r_location)
    location = UserLocation.new
    (Taobao::Location.attr_names ).each do |attr|
      val = r_location.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      location.send("#{attr}=",val)       
    end
    self.user_location = location
  end
  #同步user_credit
  def syn_credit(r_credit)
    credit = UserCredit.new
    (Taobao::UserCredit.attr_names ).each do |attr|
      val = r_credit.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      credit.send("#{attr}=",val)       
    end
    credit
  end

end
