class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :activate, :resend_activation, :send_activation]
  
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
  
  def resend_activation
  end
  
  def send_activation
    user = User.find_by_email(params[:email])
    
    if !user.activated?
      Mailer.deliver_welcome_email(user)
      flash[:notice] = "Activation email sent"
    else
      flash[:error] = "You already activated your account."
    end
    
    redirect_to resend_activation_path
  end
end
