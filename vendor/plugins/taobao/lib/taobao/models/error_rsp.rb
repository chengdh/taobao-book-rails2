require 'taobao/model'

module Taobao
  class ErrorRsp < Error
    def self.elm_name
      "error_response"
    end

    def to_s
      "Taobao::ErrorRsp(#{code}): #{msg}"
    end
  end
end
