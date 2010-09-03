require 'taobao/model'

module Taobao
  class User < Model
    def self.elm_name
      "user"
    end

    def self.attr_names
      [
        :user_id,
        :uid,
        :nick,
        :sex,
        :buyer_credit,
        :seller_credit,
        :location,
        :created,
        :last_visit,
        :birthday,
        :type,
        :has_more_pic,
        :item_img_num,
        :item_img_size,
        :prop_img_num,
        :prop_img_size,
        :auto_repost,
        :promoted_type,
        :status,
        :alipay_bind,
        :consumer_protection,
        :alipay_account,
        :alipay_no,
        :email,
        :magazine_subscribe,
        :vertical_market
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
