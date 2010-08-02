class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items,:id=>false do |t|
      t.string :iid,:limit => 32
      t.integer :num_iid,:null => false
      t.string :detail_url,:limit => 200
      t.string :title,:null => false,:limit => 60
      t.string :nick,:null => false,:limit => 60
      t.string :type,:null => false,:limit => 20
      t.integer :cid,:null => false
      t.text :desc,:null => false,:limit => 25000
      t.string :pic_url,:limit => 200
      t.integer :num,:default => 0
      t.integer :valid_thru,:default => 14
      t.datetime :list_time
      t.datetime :delist_time
      t.string :stuff_status,:limit => 20
      t.decimal :price,:precision => 15,:scale => 2
      t.decimal :post_fee,:precision => 15,:scale => 2
      t.decimal :express_fee,:precision => 15,:scale => 2
      t.decimal :ems_fee,:precision => 15,:scale => 2
      t.decimal :ems_fee,:precision => 15,:scale => 2
      t.boolean :has_discount,:default => true
      t.string :freight_payer,:null => false,:default => "seller"
      t.boolean :has_invoice,:default => true
      t.boolean :has_warranty,:default => true
      t.boolean :has_showcase,:default => true
      t.datetime :modified
      #t.string :increment
      t.boolean :auto_repost,:default => true
      t.string :approve_status,:default => "onsale"
      t.integer :postage_id
      t.integer :product_id
      t.decimal :auction_point,:precision => 15,:scale => 2
      t.integer :outer_id
      t.boolean :is_virtural,:default => false
      t.boolean :is_taobao,:default => true
      t.boolean :is_ex,:default => false
      t.boolean :is_timing,:default => false
      t.boolean :is_3D,:default => false
      t.integer :score
      t.integer :volume
      t.boolean :one_station,:default => false
      t.string :second_kill,:limit => 20
      t.string :auto_fill,:limit => 20

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE items ADD PRIMARY KEY (num_iid)"
  end

  def self.down
    drop_table :items
  end
end
