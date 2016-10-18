class User < ApplicationRecord
  has_many :parking_passes
  has_many :bookings, through: :parking_passes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  validates_uniqueness_of :phone_number
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
