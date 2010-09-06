class AddGroupPosition < ActiveRecord::Migration
  def self.up
    add_column :houses, :group_position, :integer
  end

  def self.down
    remove_column :houses, :group_position
  end
end
