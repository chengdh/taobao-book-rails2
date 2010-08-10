class CreateItemProps < ActiveRecord::Migration
  def self.up
    create_table :item_props,:id => false do |t|
      t.integer :pid,:null => false,:limit => 5
      t.integer :cid,:null => false,:limit => 5
      t.string :name,:null => false,:limit => 60
      t.integer :parent_pid,:limit => 5
      t.integer :parent_vid,:limit => 5
      t.boolean :is_key_prop,:default => false
      t.boolean :is_sale_prop,:default => false
      t.boolean :is_color_prop,:default => false
      t.boolean :is_enum_prop,:default => false
      t.boolean :is_input_prop,:default => false
      t.boolean :is_item_prop,:default => false
      t.boolean :must,:default => false
      t.boolean :multi,:default => false
      t.string :status,:limit => 60
      t.integer :sort_order
      t.string :child_template,:limit => 60
      t.boolean :is_allow_alias,:null => false,:default => false
      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE item_props ADD PRIMARY KEY (pid)"
  end

  def self.down
    drop_table :item_props
  end
end
