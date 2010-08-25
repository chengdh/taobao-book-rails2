class ModifyItemPvs < ActiveRecord::Migration
  def self.up
    change_column :item_pvs,:vid,:integer,:limit => 5,:null => true
  end

  def self.down
  end
end
