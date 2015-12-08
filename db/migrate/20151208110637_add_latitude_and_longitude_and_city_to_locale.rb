class AddLatitudeAndLongitudeAndCityToLocale < ActiveRecord::Migration
  def change
    add_column :locales, :latitude, :float
    add_column :locales, :longitude, :float
    add_column :locales, :city, :string
  end
end
