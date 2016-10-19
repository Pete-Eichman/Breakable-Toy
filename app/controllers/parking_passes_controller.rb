class ParkingPassesController < ApplicationController
  before action :authenticate_user!

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
      @parking_pass = ParkingPass.new
      if @parking_pass.save
        flash[:success] = "Created Parking Pass!"
        user.owner == true
        user.save
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

end
