class CreateItemPvs < ActiveRecord::Migration
  def self.up
    create_table :item_pvs,:id => false do |t|
      t.integer :num_iid,:null => false,:limit => 5
      t.integer :pid,:null => false,:limit => 5
      t.string :prop_name,:null => false,:limit => 60
      t.integer :vid,:null => false,:limit => 5
      t.string :name,:null => false,:limit => 60
      t.string :name_alias,:limit => 60
      t.boolean :is_parent,:default => false
      t.string :status,:limit => 20
      t.integer :sort_order,:default => 0


      t.timestamps
    end
  end

  def self.down
    drop_table :item_pvs
  end
end
