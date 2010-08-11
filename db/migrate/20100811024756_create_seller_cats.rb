class CreateSellerCats < ActiveRecord::Migration
  def self.up
    create_table :seller_cats,:id => false do |t|
      t.integer :cid,:null => false,:limit => 5
      t.integer :sid,:null => false,:limit => 5
      t.integer :parent_cid,:limit => 5
      t.string :name,:limit => 60
      t.string :pic_url,:limit => 100
      t.integer :sort_order
      t.datetime :created
      t.datetime :modified

      t.timestamps
    end

    execute "ALTER TABLE seller_cats ADD PRIMARY KEY (cid)"
  end

  def self.down
    drop_table :seller_cats
  end
end
