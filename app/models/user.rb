class User < ApplicationRecord
  has_many :parking_passes
  has_many :bookings, through: :parking_passes

  validates :first_name, presence: true
  validates :last_name, presence: true

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
        if auth.provider == 'facebook'
          names = auth.info.name.split(' ', 2)
          user.first_name = names.first
          user.last_name = names.last
        end
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
