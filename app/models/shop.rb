class Shop < ActiveRecord::Base
  set_primary_key :sid
  belongs_to :item_cat,:foreign_key => :cid
  has_one :shop_score,:foreign_key => "sid"
  has_many :seller_cats,:foreign_key => "sid"
  #数据同步
  def self.synchronize(sess,nick)
    remote_shop = sess.invoke('taobao.shop.get','fields' => Taobao::Shop.fields,'nick' => nick).first
    the_shop = Shop.new
    the_shop = Shop.find(remote_shop.sid) if Shop.exists?(remote_shop.sid)
    Taobao::Shop.attr_names.each do |attr|
      val = remote_shop.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      if (the_shop.attributes.keys).include?("#{attr}")
        the_shop.send("#{attr}=",val) 
      end
    end
    the_shop.id = remote_shop.sid
    the_shop.save
    the_shop.syn_shop_score(sess,remote_shop.shop_score)
    #同步店铺类目
    SellerCat.synchronize(sess,nick,remote_shop.sid)
  end
  #同步店铺积分
  def syn_shop_score(sess,shop_score)
    return if shop_score.blank?
    self.shop_score.destroy
    new_score = ShopScore.new
    Taobao::ShopScore.attr_names.each do |attr|
      val = shop_score.send(attr)
      #对boolean型的属性进行转换
      val=1 if val=='true'
      val=0 if val=='false'
      new_score.send("#{attr}=",val) if new_score.attributes.keys.include?("#{attr}")
    end
    new_score.sid = self.id
    new_score.save
  end
end
