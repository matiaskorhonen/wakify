# Controller for managing User Sessions
class SessionsController < ApplicationController
  def new
  end
  
  # Create a new Session (i.e. login)
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      if user.activated?
        session[:user_id] = user.id
        flash[:notice] = "Logged in successfully."
        redirect_to_target_or_default(root_url)
      else
        flash[:error] = "You have to activate your account before logging in."
        redirect_to :root
      end
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  #Destro a Session (i.e. logout)
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
