require 'digest/md5'
require 'iconv'

module Taobao
  class Session
    attr_accessor :session_key
    attr_reader :top_params

    def initialize(params = {})
      @authorized = false
      if params['top_sign']
        str = params['top_appkey'] + params["top_parameters"] + params["top_session"] + ENV['TAOBAO_APP_SECRET']
        md5 = Digest::MD5.digest(str)
        sign = Base64.encode64(md5).strip

        if sign == params['top_sign']
          self.session_key = params['top_session']
          conv = Iconv.new('UTF-8','GBK')
          @top_params = Hash[*(Base64.decode64(params['top_parameters']).split('&').collect {|v| v.split('=')}).flatten]
          @authorized = true
        else
          throw InvalidSignature.new('top_sign签名验证非法!')
        end
      end
    end

    def authorized?
      @authorized
    end

    def invoke(method, params)
      res = Parse.new.process(Service.new(method, params).invoke.body)
      if res.is_a? Taobao::ErrorRsp
        ::Rails.logger.error "taobao error of #{method}: #{res.inspect}"
        raise res.sub_msg
      end
      res
    end

    class InvalidSignature < Exception
    end
  end
end
