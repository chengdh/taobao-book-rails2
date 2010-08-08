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

ActiveRecord::Schema.define(:version => 20100808095429) do

  create_table "item_cats", :primary_key => "cid", :force => true do |t|
    t.integer  "parent_cid"
    t.string   "name",       :limit => 60
    t.boolean  "is_parent",                :default => false
    t.string   "status",     :limit => 20
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_props", :primary_key => "pid", :force => true do |t|
    t.integer  "cid",                                             :null => false
    t.string   "name",           :limit => 60, :default => "",    :null => false
    t.integer  "parent_pid"
    t.integer  "parent_vid"
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

  create_table "items", :primary_key => "num_iid", :force => true do |t|
    t.string   "iid",            :limit => 32
    t.string   "detail_url",     :limit => 200
    t.string   "title",          :limit => 60,                                      :default => "",       :null => false
    t.string   "nick",           :limit => 60,                                      :default => "",       :null => false
    t.string   "type",           :limit => 20,                                      :default => "",       :null => false
    t.integer  "cid",                                                                                     :null => false
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
    t.integer  "postage_id"
    t.integer  "product_id"
    t.decimal  "auction_point",                      :precision => 15, :scale => 2
    t.integer  "outer_id"
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
  end

  create_table "prop_values", :primary_key => "vid", :force => true do |t|
    t.integer  "pid"
    t.string   "name",       :limit => 60, :default => "", :null => false
    t.string   "name_alias", :limit => 60
    t.boolean  "is_parent"
    t.string   "status",     :limit => 20
    t.integer  "sort_order",               :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
