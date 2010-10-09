require 'digest/md5'
require 'net/http'
require 'open-uri'
require 'rest_client'
require 'iconv'

module Taobao
  class Service
    DEBUG = false

    def initialize(method, options={})
      options = options.clone

      @params = {
        'app_key' => ENV['TAOBAO_APP_KEY'],
        'method'=> method,
        'format'=>'xml',
        'v'=>'2.0',
        'sign_method' => 'md5',
        'timestamp'=> Time.now.strftime("%Y-%m-%d %H:%M:%S")
      }

      tmp_params = @params.merge(options)
      tmp_params.delete("image")
      @params.merge!(options)
      #将nick进行urlencode编码
      conv = Iconv.new('UTF-8','GBK')
      tmp_params['nick'] = conv.iconv(tmp_params['nick']) if !tmp_params['nick'].blank?
      #tmp_params['nicks'] = tmp_params['nicks'].URLEncode if !tmp_params['nicks'].blank?
      @params['nick'] = conv.iconv(@params['nick']) if !@params['nick'].blank?

      str = ENV['TAOBAO_APP_SECRET'] + (tmp_params.sort.collect { |c| "#{c[0]}#{c[1]}" }).join("") + ENV['TAOBAO_APP_SECRET']
      @params["sign"] = Digest::MD5.hexdigest(str).upcase!
    end

    def invoke
      #Net::HTTP.post_form(URI.parse(ENV['TAOBAO_REST_ENDPOINT']), @params)
      #设置为使用RestClient进行POST
      RestClient.post(ENV['TAOBAO_REST_ENDPOINT'], @params)
    end
  end
end
