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
  #获取isv订阅信息
  def self.get_subscribe_message(sess)
    ret = sess.invoke("taobao.increment.subscribemessage.get","fields" => Taobao::SubscribeMessage.fields)
    if ret.is_a? Taobao::ErrorRsp
      nil
    else
      ret.first
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
  #货物用户授权信息
  def self.get_authorize_message(sess)
    ret = sess.invoke("aobao.increment.authorizemessages.get","fields" => Taobao::AuthorizeMessage.fields,"nicks" => sess.top_params['visitor_nick'] )
    ret
  end
end
