class AddNewHouseType < ActiveRecord::Migration
  def self.up
    HouseType.create :title => "Для всех", 
                     :name => "all"
  end

  def self.down
  end
end
