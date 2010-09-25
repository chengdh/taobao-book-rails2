class ImportProvince < ActiveRecord::Migration
  def self.up
    Province.import_csv(RAILS_ROOT + "/db/migrate")
  end

  def self.down
    Province.destroy_all
  end
end
