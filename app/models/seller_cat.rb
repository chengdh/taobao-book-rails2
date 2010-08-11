class SellerCat < ActiveRecord::Base
  set_primary_key :cid
  belongs_to :shop,:foreign_key => "sid"
  acts_as_tree :foreign_key => "parent_cid",:order => "sort_order"
  #同步店铺自定义类目
  #sid 店铺id
  #FIXME 添加事务处理
  def self.synchronize(sess,nick,sid)
    seller_cats = sess.invoke("taobao.sellercats.list.get","fields" =>Taobao::SellerCat.fields,"nick" => nick)
    seller_cats.each do |remote_seller_cat|
      seller_cat = SellerCat.new 
      seller_cat = SellerCat.find(remote_seller_cat.cid) if SellerCat.exists?(remote_seller_cat.cid)
      Taobao::SellerCat.attr_names.each do |attr| 
        val = remote_seller_cat.send(attr)
        #对boolean型的属性进行转换
        val=1 if val=='true'
        val=0 if val=='false'
        seller_cat.send("#{attr}=",val) if (seller_cat.attributes.keys).include?("#{attr}")
      end
      seller_cat.id = remote_seller_cat.cid
      seller_cat.sid = sid
      seller_cat.save
    end
  end
end
