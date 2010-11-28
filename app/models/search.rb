class Search < ActiveRecord::Base
  has_many :locations
  has_many :prices
  has_many :numbers 
  has_many :beaches

  accepts_nested_attributes_for :locations, :allow_destroy => true
  accepts_nested_attributes_for :prices, :allow_destroy => true
  accepts_nested_attributes_for :numbers, :allow_destroy => true
  accepts_nested_attributes_for :beaches, :allow_destroy => true
end
