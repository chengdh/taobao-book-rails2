class CreateSkus < ActiveRecord::Migration
  def self.up
    create_table :skus,:id => false do |t|
      t.integer :sku_id,:null => false,:limit => 5
      t.integer :num_iid,:null => false,:limit => 5
      t.integer :quantity
      t.decimal :price,:precision => 15,:scale => 2
      t.string :outer_id,:limit => 20
      t.datetime :created
      t.datetime :modified
      t.string :status,:limit => 20

      t.timestamps
    end
    execute "ALTER TABLE skus ADD PRIMARY KEY (sku_id)"
  end

  def self.down
    drop_table :skus
  end
end
