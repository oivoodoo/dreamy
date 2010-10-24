class House < ActiveRecord::Base
  has_many :photos
  has_many :assets

  belongs_to :number
  belongs_to :location
  belongs_to :price
  belongs_to :house_type
  belongs_to :house_container

  default_scope :order => "houses.group_position"
  acts_as_list :scope => :house_container

  named_scope :for_rent, lambda {|scope| {:conditions => ["(houses.house_type = 'rent' or houses.house_type = 'all')"]}}
  named_scope :for_sale, lambda {|scope| {:conditions => ["(houses.house_type = 'sale' or houses.house_type = 'all')"]}}
  named_scope :for_all, lambda {|scope| {:conditions => ["(houses.house_type = 'all')"]}}

  accepts_nested_attributes_for :photos, :allow_destroy => true
  accepts_nested_attributes_for :assets, :allow_destroy => true

  cattr_reader :per_page
  @@per_page = 20

  def thumb_photo
    unless self.photos.first.nil?
      return self.photos.first.photo.url(:thumb)
    else
      return "None"
    end
  end

  def visible_assets
    a = []
    assets.each{|r|
      a << r if r.is_visible
    }
    a
  end

  class << self
    def find_by_query(query, page, house_types)
      House.house_type_name_equals(house_types).
            price_id_like(query.price_id).
            location_id_like(query.location_id).
            number_id_like(query.number_id).
            is_visible_eq(true).
            ascend_by_group_position.
            paginate(:page => page)
   end

    def find_main
      House.find(:first, :order => "updated_at DESC", :conditions => ["is_main = ?", "1"])
    end

    def find_main_photo
      house = self.find_main
      if not house.nil? and not house.number_photo.nil? then
        house.photos[house.number_photo]
      elsif not house.nil? then
        house.photos[0]
      end
    end

    def is_rent?(param)
      "rent" == param or "all" == param
    end

    def is_sale?(param)
      "sale" == param or "all" == param
    end

    def is_all?(param)
      "all" == param
    end

  end
end

