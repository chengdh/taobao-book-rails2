class AddTypeToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :type, :string,:limit => 20
  end

  def self.down
    remove_column :items, :type
  end
end
