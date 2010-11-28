class AddBeachToHouseColumns < ActiveRecord::Migration
  def self.up
    add_column :houses, :beach_id, :integer
  end

  def self.down
    remove_column :houses, :beach_id
  end
end
