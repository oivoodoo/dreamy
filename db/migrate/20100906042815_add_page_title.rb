class AddPageTitle < ActiveRecord::Migration
  def self.up
    add_column :houses, :page_title, :string
  end

  def self.down
    remove_column :houses, :page_title
  end
end
