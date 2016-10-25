class MapsController < ApplicationController
  before_action :authenticate_user!
  def index
    @key = ENV["GOOGLE_MAPS_KEY"]
  end
end
