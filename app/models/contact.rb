class Contact < ActiveRecord::Base
  default_scope :order => "created_at desc"
end
