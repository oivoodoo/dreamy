class Location < ActiveRecord::Base 
  belongs_to :search
  has_many :houses
end
