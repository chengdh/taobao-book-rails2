# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100903092809) do

  create_table "item_cats", :primary_key => "cid", :force => true do |t|
    t.integer  "parent_cid", :limit => 8
    t.string   "name",       :limit => 60
    t.boolean  "is_parent",                :default => false
    t.string   "status",     :limit => 20
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_imgs", :force => true do |t|
    t.integer  "img_id",     :limit => 8,                   :null => false
    t.integer  "num_iid",    :limit => 8,                   :null => false
    t.string   "url",        :limit => 100, :default => "", :null => false
    t.integer  "position"
    t.datetime "created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_props", :primary_key => "pid", :force => true do |t|
    t.integer  "cid",            :limit => 8,                     :null => false
    t.string   "name",           :limit => 60, :default => "",    :null => false
    t.integer  "parent_pid",     :limit => 8
    t.integer  "parent_vid",     :limit => 8
    t.boolean  "is_key_prop",                  :default => false
    t.boolean  "is_sale_prop",                 :default => false
    t.boolean  "is_color_prop",                :default => false
    t.boolean  "is_enum_prop",                 :default => false
    t.boolean  "is_input_prop",                :default => false
    t.boolean  "is_item_prop",                 :default => false
    t.boolean  "must",                         :default => false
    t.boolean  "multi",                        :default => false
    t.string   "status",         :limit => 60
    t.integer  "sort_order"
    t.string   "child_template", :limit => 60
    t.boolean  "is_allow_alias",               :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_pvs", :force => true do |t|
    t.integer  "num_iid",    :limit => 8,                     :null => false
    t.integer  "pid",        :limit => 8,                     :null => false
    t.string   "prop_name",  :limit => 60, :default => "",    :null => false
    t.integer  "vid",        :limit => 8
    t.string   "name",       :limit => 60, :default => "",    :null => false
    t.string   "name_alias", :limit => 60
    t.boolean  "is_parent",                :default => false
    t.string   "status",     :limit => 20
    t.integer  "sort_order",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_seller_cats", :force => true do |t|
    t.integer  "num_iid",    :limit => 8, :null => false
    t.integer  "cid",        :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :primary_key => "num_iid", :force => true do |t|
    t.string   "iid",            :limit => 32
    t.string   "detail_url",     :limit => 200
    t.string   "title",          :limit => 60,                                      :default => "",       :null => false
    t.string   "nick",           :limit => 60,                                      :default => "",       :null => false
    t.string   "item_type",      :limit => 20,                                      :default => "",       :null => false
    t.integer  "cid",            :limit => 8,                                                             :null => false
    t.text     "desc",           :limit => 16777215,                                                      :null => false
    t.string   "pic_url",        :limit => 200
    t.integer  "num",                                                               :default => 0
    t.integer  "valid_thru",                                                        :default => 14
    t.datetime "list_time"
    t.datetime "delist_time"
    t.string   "stuff_status",   :limit => 20
    t.decimal  "price",                              :precision => 15, :scale => 2
    t.decimal  "post_fee",                           :precision => 15, :scale => 2
    t.decimal  "express_fee",                        :precision => 15, :scale => 2
    t.decimal  "ems_fee",                            :precision => 15, :scale => 2
    t.boolean  "has_discount",                                                      :default => true
    t.string   "freight_payer",                                                     :default => "seller", :null => false
    t.boolean  "has_invoice",                                                       :default => true
    t.boolean  "has_warranty",                                                      :default => true
    t.boolean  "has_showcase",                                                      :default => true
    t.datetime "modified"
    t.boolean  "auto_repost",                                                       :default => true
    t.string   "approve_status",                                                    :default => "onsale"
    t.integer  "postage_id",     :limit => 8
    t.integer  "product_id",     :limit => 8
    t.decimal  "auction_point",                      :precision => 15, :scale => 2
    t.integer  "outer_id",       :limit => 8
    t.boolean  "is_virtural",                                                       :default => false
    t.boolean  "is_taobao",                                                         :default => true
    t.boolean  "is_ex",                                                             :default => false
    t.boolean  "is_timing",                                                         :default => false
    t.boolean  "is_3D",                                                             :default => false
    t.integer  "score"
    t.integer  "volume"
    t.boolean  "one_station",                                                       :default => false
    t.string   "second_kill",    :limit => 20
    t.string   "auto_fill",      :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          :limit => 20
    t.string   "city",           :limit => 20
    t.string   "type",           :limit => 20
  end

  create_table "local_areas", :force => true do |t|
    t.integer  "area_type",                                :null => false
    t.string   "name",       :limit => 60, :default => "", :null => false
    t.integer  "parent_id",  :limit => 8
    t.string   "zip",        :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postage_modes", :force => true do |t|
    t.integer  "postage_id",   :limit => 8,                                                 :null => false
    t.string   "postage_type", :limit => 20,                                :default => "", :null => false
    t.decimal  "price",                      :precision => 15, :scale => 2
    t.decimal  "increase",                   :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postages", :primary_key => "postage_id", :force => true do |t|
    t.string   "name",             :limit => 60,                                 :default => "", :null => false
    t.string   "memo",             :limit => 200,                                :default => "", :null => false
    t.decimal  "post_price",                      :precision => 15, :scale => 2
    t.decimal  "post_increase",                   :precision => 15, :scale => 2
    t.decimal  "express_price",                   :precision => 15, :scale => 2
    t.decimal  "express_increase",                :precision => 15, :scale => 2
    t.decimal  "ems_price",                       :precision => 15, :scale => 2
    t.decimal  "ems_increase",                    :precision => 15, :scale => 2
    t.string   "nick",             :limit => 60,                                 :default => "", :null => false
    t.datetime "created"
    t.datetime "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prop_values", :primary_key => "vid", :force => true do |t|
    t.integer  "pid",        :limit => 8
    t.string   "name",       :limit => 60, :default => "", :null => false
    t.string   "name_alias", :limit => 60
    t.boolean  "is_parent"
    t.string   "status",     :limit => 20
    t.integer  "sort_order",               :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seller_cats", :primary_key => "cid", :force => true do |t|
    t.integer  "sid",        :limit => 8,   :null => false
    t.integer  "parent_cid", :limit => 8
    t.string   "name",       :limit => 60
    t.string   "pic_url",    :limit => 100
    t.integer  "sort_order"
    t.datetime "created"
    t.datetime "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_scores", :primary_key => "sid", :force => true do |t|
    t.integer  "item_score",     :default => 0
    t.integer  "service_score",  :default => 0
    t.integer  "delivery_score", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", :primary_key => "sid", :force => true do |t|
    t.integer  "cid",          :limit => 8,                   :null => false
    t.string   "nick",         :limit => 20,  :default => "", :null => false
    t.string   "title",        :limit => 200
    t.string   "desc",         :limit => 500
    t.string   "bulletin",     :limit => 500
    t.string   "pic_path",     :limit => 200
    t.integer  "remain_count"
    t.datetime "created"
    t.datetime "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sku_pvs", :force => true do |t|
    t.integer  "sku_id",     :limit => 8,                     :null => false
    t.integer  "pid",        :limit => 8,                     :null => false
    t.string   "prop_name",  :limit => 60, :default => "",    :null => false
    t.integer  "vid",        :limit => 8,                     :null => false
    t.string   "name",       :limit => 60, :default => "",    :null => false
    t.string   "name_alias", :limit => 60
    t.boolean  "is_parent",                :default => false
    t.string   "status",     :limit => 20
    t.integer  "sort_order",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skus", :primary_key => "sku_id", :force => true do |t|
    t.integer  "num_iid",    :limit => 8,                                 :null => false
    t.integer  "quantity"
    t.decimal  "price",                    :precision => 15, :scale => 2
    t.string   "outer_id",   :limit => 20
    t.datetime "created"
    t.datetime "modified"
    t.string   "status",     :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_credits", :force => true do |t|
    t.integer  "level"
    t.integer  "score"
    t.integer  "total_num"
    t.integer  "good_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_locations", :force => true do |t|
    t.string   "zip",        :limit => 20
    t.string   "address",    :limit => 60
    t.string   "city",       :limit => 20
    t.string   "state",      :limit => 20
    t.string   "country",    :limit => 20
    t.string   "distinct",   :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "uid",                 :limit => 30, :default => "",    :null => false
    t.string   "nick",                :limit => 60, :default => "",    :null => false
    t.string   "sex",                 :limit => 1
    t.integer  "buyer_credit_id"
    t.integer  "seller_credit_id"
    t.integer  "location_id"
    t.datetime "created"
    t.datetime "last_visit"
    t.date     "birthday"
    t.string   "user_type",           :limit => 1,  :default => "",    :null => false
    t.boolean  "has_more_pic",                      :default => false
    t.integer  "item_img_num",                      :default => 0
    t.integer  "item_img_size",                     :default => 0
    t.integer  "prop_img_num",                      :default => 0
    t.integer  "prop_img_size",                     :default => 0
    t.string   "auto_repost",         :limit => 20
    t.string   "promoted_type",       :limit => 20
    t.string   "status",              :limit => 20
    t.string   "alipay_bind",         :limit => 20
    t.boolean  "consumer_protection"
    t.string   "alipay_account",      :limit => 60
    t.string   "alipay_no",           :limit => 60
    t.string   "email",               :limit => 60
    t.boolean  "magazine_subscribe"
    t.string   "vertical_market",     :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
