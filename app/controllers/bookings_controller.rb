class BookingsController < ApplicationController

  def index

  end

  def show
    @booking = Booking.find(params[:id])

  end

  def new
    @booking = Booking.new()
    @parking_pass = ParkingPass.find(params[:parking_pass_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @parking_pass = ParkingPass.find(params[:parking_pass_id])
    flash[:success] = "Created Booking!"
    @booking.save
    @parking_pass.update_attribute(:booking_id, booking_params)
    @parking_pass.save
    current_user.update_attribute(:booking_id, booking_params)
    current_user.save
    redirect_to user_path(@current_user)
  end



  def edit

  end

  def update

  end

  def destroy

  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time).merge(user: current_user).merge(parking_pass: ParkingPass.find(params[:parking_pass_id]))
  end

end
