class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users,:id => false do |t|
      t.integer :user_id,:limit => 5,:null => false
      t.string  :uid,:limit => 30,:null => false
      t.string  :nick,:limit => 60,:null => false
      t.string  :sex,:limit => 1
      t.integer  :buyer_credit_id
      t.integer  :seller_credit_id
      t.integer  :location_id
      t.datetime  :created
      t.datetime  :last_visit
      t.date  :birthday
      t.string  :user_type,:limit => 1,:null => false
      t.boolean  :has_more_pic,:default => false
      t.integer  :item_img_num,:default => 0
      t.integer  :item_img_size,:default => 0
      t.integer  :prop_img_num,:default => 0
      t.integer  :prop_img_size,:default => 0
      t.string  :auto_repost,:limit => 20
      t.string  :promoted_type,:limit => 20
      t.string  :status,:limit => 20
      t.string  :alipay_bind,:limit => 20
      t.boolean  :consumer_protection
      t.string  :alipay_account,:limit => 60
      t.string  :alipay_no,:limit => 60
      t.string  :email,:limit => 60
      t.boolean  :magazine_subscribe
      t.string  :vertical_market,:limit => 30

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE users ADD PRIMARY KEY (user_id)"
  end

  def self.down
    drop_table :users
  end
end
