class ChangeQueryColumns < ActiveRecord::Migration
  def self.up
    remove_column :queries, :location
    remove_column :queries, :cost
    remove_column :queries, :number

    add_column :queries, :location_id, :integer
    add_column :queries, :price_id, :integer
    add_column :queries, :number_id, :integer
  end

  def self.down
  end
end
