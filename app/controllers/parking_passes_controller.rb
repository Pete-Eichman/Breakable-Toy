class ParkingPassesController < ApplicationController

  def index
    @parking_passes = ParkingPass.all.order(created_at: :desc)
  end

  def show
  end

  def new
    if current_user
      @parking_pass = ParkingPass.new
    else
      flash[:errors] = "You must be logged in to create a parking pass."
      redirect_to root_path
    end
  end

  def create
    if current_user
      @parking_pass = ParkingPass.new(parking_pass_params)
      if @parking_pass.save
        flash[:success] = "Created Parking Pass!"
        current_user.owner == true
        current_user.save
        redirect_to user_path(@current_user)
      else
        flash[:errors] = "Parking Pass could not be created"
        render :new
      end
    end
  end

  def edit
    @parking_pass = ParkingPass.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def parking_pass_params
    params.require(:parking_pass).permit(:parking_pass, :pass_number, :address, :price_per_hour).merge(user: current_user)
  end

end
