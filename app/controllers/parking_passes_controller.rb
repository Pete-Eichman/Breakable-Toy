class ParkingPassesController < ApplicationController

  def index
    @parking_passes = ParkingPass.all
    render json: @parking_passes.to_json
  end

  def show
    @parking_pass = ParkingPass.find(params[:id])
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
      if @parking_pass.geolocate['results'][0].nil?
        flash[:errors] = "Parking Pass could not be mapped"
        render :new
      else
        @parking_pass.lat = @parking_pass.geolocate['results'][0]['geometry']['location']['lat']
        @parking_pass.lng = @parking_pass.geolocate['results'][0]['geometry']['location']['lng']
        @parking_pass.save
        flash[:success] = "Created Parking Pass!"
        redirect_to user_path(@current_user)
      end
    end
  end

  def edit
    @parking_pass = ParkingPass.find(params[:id])
  end

  def update
    @parking_pass = ParkingPass.find(params[:id])
    @parking_pass.address = params[:parking_pass][:address]
    @parking_pass.pass_number = params[:parking_pass][:pass_number]
    @parking_pass.price_per_hour  = params[:parking_pass][:price_per_hour]
    if @parking_pass.save
      flash[:success] = "Parking Pass was Updated!"
      redirect_to parking_pass_path(@parking_pass)
    else
      flash[:error] = "Parking Pass could not be Updated"
      render parking_pass_path(@parking_pass)
    end
  end

  def destroy
    @parking_pass = ParkingPass.find(params[:id])
    @user = @parking_pass.user
    if authorized_party
      @parking_pass.destroy
      flash[:success] = "Parking Pass was deleted!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Parking Pass could not be deleted"
      redirect_to user_path(@user)
    end
  end

  private

  def parking_pass_params
    params.require(:parking_pass).permit(:parking_pass, :pass_number, :address, :price_per_hour).merge(user: current_user)
  end

  def authorized_party
    current_user.try(:admin?) || current_user == @parking_pass.user
  end

end
