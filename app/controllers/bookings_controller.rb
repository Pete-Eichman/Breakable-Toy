class BookingsController < ApplicationController

  def index

  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @parking_pass = ParkingPass.find(params[:parking_pass_id])
  end

  def create
    # @booking = Booking.new(booking_params)

    # @parking_pass = ParkingPass.find(params[:parking_pass_id])
    # flash[:success] = "Created Booking!"
    # @booking.save
    # @parking_pass.update_attribute(:booking_id, booking_params)
    # @parking_pass.save
    # @user.update_attribute(:booking_id, booking_params)
    # @user.save
    # redirect_to parking_pass_path(@parking_pass)
    @booking = Booking.new(booking_params)
    @parking_pass = ParkingPass.find(params[:parking_pass_id])
    @booking.parking_pass = @parking_pass
    @user = current_user
    @booking.user = @user


    if @booking.save
      flash[:notice] = 'Sending your booking request now.'
      @booking.notify_host(true)
      redirect_to parking_pass_path(@parking_pass)
    else
      flash[:errors] = "Booking could not be saved."
      render :new
    end
  end



  def edit

  end

  def update

  end

  def destroy

  end

  def accept_or_reject
    incoming = Sanitize.clean(params[:From]).gsub(/^\+\d/, '')
    sms_input = params[:Body].downcase
    begin
      @host = User.find_by(phone_number: incoming)
      @reservation = @host.pending_booking

      if sms_input == "accept" || sms_input == "yes"
        @booking.confirm!
      else
        @booking.reject!
      end

      @host.check_for_bookings_pending

      @booking.notify_guest

      sms_reponse = "You have successfully #{@booking.status} the booking."
      respond(sms_reponse)
    rescue
      sms_reponse = "Sorry, it looks like you don't have any bookings to respond to."
      respond(sms_reponse)
    end
  end

  private

  def respond(message)
    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render xml: response.text
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:first_name, :date, :last_name, :phone_number, :start_time, :end_time, :message)
  end

end
