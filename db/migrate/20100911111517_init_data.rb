class InitData < ActiveRecord::Migration
  def self.up
    ItemCat.import_csv(RAILS_ROOT + "/db/migrate")
    LocalArea.import_csv(RAILS_ROOT + "/db/migrate")
  end

  def self.down
    ItemCat.destroy_all
    LocalArea.destroy_all
  end
end
