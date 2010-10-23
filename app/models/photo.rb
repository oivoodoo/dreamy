class Photo < ActiveRecord::Base
  belongs_to :house
  
  has_attached_file :photo, :styles => { :medium => "455x305>", :thumb => "125x72>" }
  
  def is_valid?
    not (photo_file_size.nil? or photo_content_type.nil?)
  end
end
