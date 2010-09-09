require 'taobao/model'

module Taobao
  class SubscribeMessage < Model
    def self.elm_name
      "subscribe_message"
    end

    def self.attr_names
      [
        :app_key,
        :start_date,
        :end_date,
        :modified,
        :subscriptions,
        :valid,
        :notify_infos,
        :notify_url
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
