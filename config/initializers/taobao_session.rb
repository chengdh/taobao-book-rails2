#扩展taobao session
require 'nokogiri'
module Taobao
  class SessionKey
    AUTH_URL = "http://open.taobao.com/isv/authorize.php"
    SESSION_URL = "http://container.api.tbsandbox.com/container?"
    #获取授权码
    def self.get_authcode(nick)
      params = Hash.new
      params["appkey"] = ENV['TAOBAO_APP_KEY']
      params["nick"] = nick   #卖家nick
      params["zhxz"] = 2  #自定义账号
      rsp = Net::HTTP.post_form(URI.parse(AUTH_URL),params)
      doc = Nokogiri::HTML(rsp.body)
      input_auth_code = doc.css("input#autoInput")
      input_auth_code.first['value']
    end
    #获取sessionkey
    def self.get_session(nick)
      auth_code = self.get_authcode(nick)
      ret_str = Net::HTTP.get_response(URI.parse(SESSION_URL + "authcode=#{auth_code}")).body
      #将返回结果分解为hash
      ret_hash = Hash[*(ret_str.split('&').collect {|v| v.split('=')}).flatten]
      sess = Taobao::Session.new(ret_hash)
    end
  end
end
