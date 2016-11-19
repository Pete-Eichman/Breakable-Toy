class SessionsController < Devise::SessionsController
  def new
    user = User.find_by(email: params[:user][:email]) if params[:user]

    if params[:user] && !user
      flash[:errors] = "You must sign in with an existing account, or create an account to sign in."
      redirect_to new_user_registration_path
    else
      super
    end
  end
end
