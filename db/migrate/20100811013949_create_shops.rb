class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops,:id => false do |t|
      t.integer :sid,:null => false,:limit => 5
      t.integer :cid,:null => false,:limit => 5
      t.string :nick,:null => false,:limit => 20
      t.string :title,:limit => 200
      t.string :desc,:limit => 500
      t.string :bulletin,:limit => 500
      t.string :pic_path,:limit => 200
      t.integer :remain_count
      t.datetime :created
      t.datetime :modified

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE shops ADD PRIMARY KEY (sid)"

  end

  def self.down
    drop_table :shops
  end
end
