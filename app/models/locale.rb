class Locale < ActiveRecord::Base
  resourcify
  belongs_to :category
  # Validates locale
  validates :title, :description, :state, :street,
    :number, :city, :category_id, presence: true
    
   # Geocoder
  geocoded_by :location do |obj, results|
    if geo = results.first
        # populate your model
        obj.latitude = geo.latitude
        obj.longitude = geo.longitude
      else
      obj.street = nil
    end
  end
  before_validation :geocode, :if => :street_changed?

  # Joins address to consult coords
  def location
  	[state, city, street, number].compact.join(', ')
  end

  scope :find_status, -> {where(status: true)}
   
   after_create :set_status
   protected
  
  # Set a default value for the status
  def set_status
     update(status: false)
  end
end
