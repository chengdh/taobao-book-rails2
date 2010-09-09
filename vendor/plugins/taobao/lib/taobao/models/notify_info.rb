require 'taobao/model'

module Taobao
  class NotifyInfo < Model
    def self.elm_name
      "notify_info"
    end

    def self.attr_names
      [
        :topic,
        :is_notify
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
