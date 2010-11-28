class ConnectBeachWithSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :beach_id, :integer
  end

  def self.down
    remove_column :searches, :beach_id
  end
end
