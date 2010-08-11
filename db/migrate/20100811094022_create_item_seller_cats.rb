class CreateItemSellerCats < ActiveRecord::Migration
  def self.up
    create_table :item_seller_cats,:id => false do |t|
      t.integer :num_iid,:null => false,:limit => 5
      t.integer :cid,:null => false,:limit => 5

      t.timestamps
    end
  end

  def self.down
    drop_table :item_seller_cats
  end
end
