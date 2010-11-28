class ConnectQueryWithBeach < ActiveRecord::Migration
  def self.up
    add_column :queries, :beach_id, :integer
  end

  def self.down
    remove_column :queries, :beach_id
  end
end
