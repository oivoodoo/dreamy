class AddSeoBlockForCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalog_pages, :bottom, :text
    add_column :sale_pages, :bottom, :text
  end

  def self.down
    remove_column :sale_pages, :bottom
    remove_column :catalog_pages, :bottom
  end
end
