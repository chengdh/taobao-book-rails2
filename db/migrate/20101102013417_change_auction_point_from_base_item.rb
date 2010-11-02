class ChangeAuctionPointFromBaseItem < ActiveRecord::Migration
  def self.up
    change_column :items,:auction_point,:integer
  end

  def self.down
    change_column :items,:auction_point,:decimal,:precision => 15,:scale => 2
  end
end
