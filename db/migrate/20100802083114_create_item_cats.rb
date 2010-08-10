class CreateItemCats < ActiveRecord::Migration
  def self.up
    create_table :item_cats,:id => false do |t|
      t.integer :cid,:null => false,:limit => 5
      t.integer :parent_cid,:limit => 5
      t.string :name,:limit => 60
      t.boolean :is_parent,:default => false
      t.string :status,:limit => 20
      t.integer :sort_order

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE item_cats ADD PRIMARY KEY (cid)"

  end

  def self.down
    drop_table :item_cats
  end
end
