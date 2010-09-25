#省份.城市列表
class CreateProvinces < ActiveRecord::Migration
  def self.up
    create_table :provinces do |t|
      t.string :name,:limit => 40,:null => false
      t.integer :parent_id,:null => false

      t.timestamps
    end
    #增加一个根类
    province = Province.new(:name => 'root',:parent_id => -1)
    province.save
  end

  def self.down
    drop_table :provinces
  end
end
