class Locale < ActiveRecord::Base
  belongs_to :category
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
end
