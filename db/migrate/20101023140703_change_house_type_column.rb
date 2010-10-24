class ChangeHouseTypeColumn < ActiveRecord::Migration
  def self.up
    add_column :houses, :house_type_id, :integer

    @all_id = HouseType.find_by_name('all').id
    @sale_id = HouseType.find_by_name('sale').id
    @rent_id = HouseType.find_by_name('rent').id

    House.all.each do |h|
      if h.house_type == 'all' || h.house_type.nil?
        h.house_type_id = @all_id
      end
      if h.house_type == 'sale'
        h.house_type_id = @sale_id
      end
      if h.house_type == 'rent'
        h.house_type_id = @rent_id
      end
      h.save
    end

    remove_column :houses, :house_type
  end

  def self.down
    remove_column :houses, :house_type_id
  end
end
