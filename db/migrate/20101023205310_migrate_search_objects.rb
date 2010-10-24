class MigrateSearchObjects < ActiveRecord::Migration
  def self.up
    remove_column :numbers, :sale_search_id
    remove_column :numbers, :house_id
    remove_column :locations, :sale_search_id
    remove_column :locations, :house_id
    remove_column :prices, :sale_search_id
    remove_column :prices, :house_id
  end

  def self.down
    add_column :numbers, :sale_search_id, :integer
    add_column :numbers, :house_id, :integer
    add_column :locations, :sale_search_id, :integer
    add_column :locations, :house_id, :integer
    add_column :prices, :sale_search_id, :integer
    add_column :prices, :house_id, :integer
  end
end
