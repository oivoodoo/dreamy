class Asset < ActiveRecord::Base

  belongs_to :house

  has_attached_file :document

end
