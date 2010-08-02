require 'taobao/model'

module Taobao
  class Error < Model
    def self.elm_name
      "error"
    end

    def self.attr_names
      [
       :msg,
       :code,
       :args
      ]
    end

    for a in attr_names
      attr_accessor a
    end

    def to_s
      "Taobao::Error(#{code}): #{msg}"
    end
  end
end
