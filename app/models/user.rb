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
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    if User.where(email: auth.info.email)[0]
      User.where(email: auth.info.email)[0]
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name if auth.provider == 'facebook'
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
