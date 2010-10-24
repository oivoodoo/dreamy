class UpdateSearchOptions < ActiveRecord::Migration
  def self.up
    House.all do |h|
      h.location = Location.first if h.location.nil?
      h.number = Number.first if h.number.nil?
      h.price = Price.first if h.price.nil?
      h.save
    end
  end

  def self.down
  end
end
