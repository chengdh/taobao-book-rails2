class ChangeUserUid < ActiveRecord::Migration
  def self.up
    change_column :users,:uid,:string,:limit => 60
    change_column :users,:vertical_market,:string,:limit => 60
  end

  def self.down
  end
end
