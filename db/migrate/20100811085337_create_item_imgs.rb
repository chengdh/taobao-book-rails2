class CreateItemImgs < ActiveRecord::Migration
  def self.up
    create_table :item_imgs,:id => false do |t|
      t.integer :id,:null => false,:limit => 5
      t.integer :num_iid,:null => false,:limit => 5
      t.string :url,:null => false,:limit => 100
      t.integer :position
      t.datetime :created

      t.timestamps
    end

    execute "ALTER TABLE item_imgs ADD PRIMARY KEY (id)"
  end

  def self.down
    drop_table :item_imgs
  end
end
