class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    
    respond_to do |format|
      if @user.id == current_user.id
        if @user.save
          flash[:notice] = "User data updated"
        else
          flash[:error] = "Something went wrong"
        end
      else
        flash[:error] = "Something went wrong"
      end
      format.html { render :action => "edit" }
    end
  end
end
