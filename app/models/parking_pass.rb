class ParkingPass < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings

  validates :pass_number, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false
  validates :price_per_hour, presence: true, allow_blank: false
end
