class Price < ActiveRecord::Base
  belongs_to :search
  has_many :houses
end
