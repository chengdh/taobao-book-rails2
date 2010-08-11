class AddLocationToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :state, :string,:limit => 20 #省份
    add_column :items, :city, :string,:limit => 20  #城市
  end

  def self.down
    remove_column :items, :city
    remove_column :items, :state
  end
end
