class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :parking_pass

  enum status: [:pending, :confirmed, :rejected ]

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :phone_number, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def notify_host(force = false)
    @host = User.find(parking_pass[:user_id])

    # Don't send the message if we have more than one or we aren't being forced
    if @host.pending_bookings.length > 1 or !force
      return
    else
      message = "You have a new booking request from #{first_name} #{last_name} for #{parking_pass.address}:

      '#{message}'

      Reply [accept] or [reject]."

      @host.send_message_via_sms(message)
    end
  end

  def reject!
    self.status = "rejected"
    save!
  end

  def notify_guest
    @guest = User.find_by(phone_number: phone_number)

    if status == "confirmed"
      message = "Your recent request to park at #{parking_pass.address} was #{status}!"
      @guest.send_message_via_sms(message)
    elsif status == "rejected"
      message = "Your recent request to park at #{parking_pass.address} was #{status}, sorry!"
    end
  end
end
