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

  def send_message_via_sms(message)
    client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )

    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: full_number,
      body: message
    )
  end

  def check_for_bookings_pending
    pending_booking.notify_host(true) if pending_booking
  end

  def full_number
    country_code_number = country_code.gsub('+', '')
    "+#{country_code_number}#{phone_number}"
  end

  def pending_booking
    bookings.where(status: "pending").first
  end

  def pending_bookings
    bookings.where(status: "pending")
  end
end
