class AddSeoBlockForCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalog_page, :bottom, :text
    add_column :sale_page, :bottom, :text
  end

  def self.down
    remove_column :sale_page, :bottom
    remove_column :catalog_page, :bottom
  end
end
