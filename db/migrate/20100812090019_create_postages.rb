#运费模板
class CreatePostages < ActiveRecord::Migration
  def self.up
    create_table :postages,:id => false do |t|
      t.integer :postage_id,:null => false,:limit => 5
      t.string :name,:null => false,:limit => 60
      t.string :memo,:null => false,:limit => 200 
      t.decimal :post_price,:precision => 15,:scale => 2 
      t.decimal :post_increase,:precision => 15,:scale => 2 
      t.decimal :express_price,:precision => 15,:scale => 2 
      t.decimal :express_increase,:precision => 15,:scale => 2 
      t.decimal :ems_price,:precision => 15,:scale => 2 
      t.decimal :ems_increase,:precision => 15,:scale => 2 
      t.string  :nick,:null => false,:limit => 60   #运费模板所属卖家昵称
      t.datetime :created
      t.datetime :modified

      t.timestamps
    end

    execute "ALTER TABLE postages ADD PRIMARY KEY (postage_id)"
  end

  def self.down
    drop_table :postages
  end
end
