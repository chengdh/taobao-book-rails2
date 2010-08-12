class CreateItemImgs < ActiveRecord::Migration
  def self.up
    #item_img中,id=0表示主图,所以需要自建主键
    create_table :item_imgs do |t|
      t.integer :img_id,:null => false,:limit => 5
      t.integer :num_iid,:null => false,:limit => 5
      t.string :url,:null => false,:limit => 100
      t.integer :position
      t.datetime :created

      t.timestamps
    end
  end

  def self.down
    drop_table :item_imgs
  end
end
