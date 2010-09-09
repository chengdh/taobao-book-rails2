class SynLog < ActiveRecord::Base
  set_primary_key :nick
  #处理ISV订阅增量信息
  def self.app_subscribe(sess)
    ret = sess.invoke("taobao.increment.app.subscribe","topics" => "trade;refund;item","status" => "all;all;all","duration" => 12)
    if ret.is_a? Taobao::ErrorRsp
      false
    else
      ret.first.valid == 'true'
    end
  end
  #用户授权ISV获取其增量信息
  def self.user_authorize(sess)
    ret = sess.invoke("taobao.increment.user.authorize","session" => sess.session_key,"duration" => 2 )
    if ret.is_a? Taobao::ErrorRsp
      false
    else
      ret.first.is_a? Taobao::AuthorizeMessage 
    end
  end
end
