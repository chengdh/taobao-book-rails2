class CreateDoubanBooks < ActiveRecord::Migration
  def self.up
    create_table :douban_books do |t|
      t.string :nick,:limit => 60,:null => false
      t.string :title,:limit => 60
      t.string :subtitle,:limit => 60
      t.string :aka,:limit => 60
      t.string :image,:limit => 200
      t.string :author,:limit => 60
      t.string :isbn10,:limit => 10
      t.string :isbn13,:limit => 13
      t.string :pubdate,:limit => 20
      t.integer :pages
      t.string :translator,:limit => 60
      t.string :price,:limit => 20
      t.string :publisher,:limit => 60
      t.string :binding,:limit =>  20
      t.text :author_intro,:limit => 3000
      t.text :summary,:limit => 3000

      t.timestamps
    end
  end

  def self.down
    drop_table :douban_books
  end
end
