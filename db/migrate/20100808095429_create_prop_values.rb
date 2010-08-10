class CreatePropValues < ActiveRecord::Migration
  def self.up
    create_table :prop_values,:id => false do |t|
      t.integer :vid,:null => false,:limit => 5
      t.integer :pid,:limit => 5
      t.string :name,:limit => 60,:null => false
      t.string :name_alias,:limit => 60
      t.boolean :is_parent,:defualt => false
      t.string :status,:limit => 20
      t.integer :sort_order,:default => 1

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE prop_values ADD PRIMARY KEY (vid)"
  end

  def self.down
    drop_table :prop_values
  end
end
