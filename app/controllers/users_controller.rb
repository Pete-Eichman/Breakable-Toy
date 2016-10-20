class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.save
    redirect_to user_path(user)
  end

  def destroy
    @user = User.find(params[:id])
    if authorized_party
      if @user.valid?
        user_valid_destroy
      else
        flash[:errors] = "User Account was not deleted."
        render user_path(@user)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def authorized_party
    current_user.try(:admin?) || current_user == @user
  end

  def admin_redirect
    if current_user.admin
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def user_valid_destroy
    @user.destroy
    flash[:success] = "User Account successfully closed"
    admin_redirect
  end
end
