class CreateUserCredits < ActiveRecord::Migration
  def self.up
    create_table :user_credits do |t|
      t.integer :level
      t.integer :score
      t.integer :total_num
      t.integer :good_num

      t.timestamps
    end
  end

  def self.down
    drop_table :user_credits
  end
end
