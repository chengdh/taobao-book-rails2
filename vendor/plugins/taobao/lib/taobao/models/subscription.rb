require 'taobao/model'

module Taobao
  class Subscription < Model
    def self.elm_name
      "subscription"
    end

    def self.attr_names
      [
        :topic,
        :status
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
