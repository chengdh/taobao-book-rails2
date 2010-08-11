class CreateShopScores < ActiveRecord::Migration
  def self.up
    create_table :shop_scores,:id => false do |t|
      t.integer :sid,:null => false,:limit => 5
      t.integer :item_score,:default => 0
      t.integer :service_score,:default => 0
      t.integer :delivery_score,:default => 0

      t.timestamps
    end
    execute "ALTER TABLE shop_scores ADD PRIMARY KEY (sid)"
  end

  def self.down
    drop_table :shop_scores
  end
end
