require 'open-uri'
require 'json'

class ParkingPass < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  acts_as_mappable  :lat_column_name => :lat, presence: true, allow_blank: false
  acts_as_mappable  :lng_column_name => :lng, presence: true, allow_blank: false

  validates :pass_number, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false
  validates :price_per_hour, presence: true, allow_blank: false

  def geolocate
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['GOOGLE_MAPS_KEY']}"
    url = URI.parse(url)
    str = url.read
    data = JSON.parse(str)
  end
end
