class CreateUserLocations < ActiveRecord::Migration
  def self.up
    create_table :user_locations do |t|
      t.string :zip,:limit => 20
      t.string :address,:limit => 60
      t.string :city,:limit => 20
      t.string :state,:limit => 20
      t.string :country,:limit => 20
      t.string :distinct,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :user_locations
  end
end
