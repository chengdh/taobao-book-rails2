class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :local_areas,:id => false do |t|
      t.integer :id,:null => false,:limit => 5
      t.integer :area_type,:null => false
      t.string :name,:null => false,:limit => 60
      t.integer :parent_id,:limit => 5
      t.string :zip,:limit => 20

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE local_areas ADD PRIMARY KEY (id)"

  end

  def self.down
    drop_table :local_areas
  end
end
