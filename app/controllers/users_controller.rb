class UsersController < ApplicationController
  before_filter :login_required, :only => [:show, :edit, :update]
  
  def show
    @user = current_user
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thank you for signing up! Please check your email for the validation link."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = current_user
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
  
  def activate
    @user = User.find_by_activation_code(params[:activation_code])
    raise ActiveRecord::RecordNotFound, "No such activation code" if @user.nil?
    
    unless @user.nil?
      @user.activation_code = nil
      @user.save
    end
  end
  
  def requests
  end
  
  def resend_activation
    user = User.find_by_email(params[:email])
    
    if !user.nil?
      if !user.activated?
        Mailer.deliver_welcome_email(user)
        flash[:notice] = "Activation email sent"
      else
        flash[:error] = "You already activated your account."
      end
    else
      flash[:error] = "No user account found for that email address"
    end
    
    redirect_to requests_path
  end
  
  def send_password_reset
    user = User.find_by_email(params[:email])
    
    if !user.nil?
      user.add_password_reset
      if user.save
        Mailer.deliver_password_reset_email(user)
        flash[:notice] = "Reset link sent"
      else
        flash[:error] = "An unknown error occured"
      end
    else
      flash[:error] = "No user account found for that email address"
    end
    
    redirect_to requests_path
  end
  
  def reset_password
    @user = User.find_by_password_reset(params[:code])
    
    if @user.password_reset_time <= 1.day.ago
      flash[:error] = "Your reset link has expired"
      redirect_to requests_path
    end
  end
  
  def change_password
    @user = User.find_by_password_reset(params[:user][:password_reset])
    
    @user.password = params[:user][:password]
    @user.password_reset = nil
    
    respond_to do |format|
        if @user.save
          flash[:notice] = "User password changed. You can now login."
        else
          flash[:error] = "Something went wrong"
        end
        format.html { redirect_to :root }
    end
  end
end
