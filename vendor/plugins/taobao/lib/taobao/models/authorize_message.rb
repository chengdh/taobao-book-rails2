require 'taobao/model'

module Taobao
  class AuthorizeMessage < Model
    def self.elm_name
      "authorize_message"
    end

    def self.attr_names
      [
        :app_key,
        :nick,
        :start_date,
        :end_date,
        :created,
        :modified,
        :status,
        :valid
      ]
    end

    for a in attr_names
      attr_accessor a
    end
  end
end
