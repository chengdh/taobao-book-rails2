class CreatePostageModes < ActiveRecord::Migration
  def self.up
    create_table :postage_modes do |t|
      t.integer :postage_id,:null => false,:limit => 5
      t.string :postage_type,:null => false,:limit => 20
      t.decimal :price,:precision => 15,:scale => 2
      t.decimal :increase,:precision => 15,:scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :postage_modes
  end
end
