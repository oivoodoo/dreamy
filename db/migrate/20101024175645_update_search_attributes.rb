class UpdateSearchAttributes < ActiveRecord::Migration
  def self.up
    House.all do |h|
      h.price_id = Price.first.id if h.price.nil?
      h.location_id = Location.first.id if h.location.nil?
      h.number_id = Number.first.id if h.number.nil?
      h.save(false)
    end
  end

  def self.down
  end
end
