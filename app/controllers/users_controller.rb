class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :activate]
  
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
    @user= User.find_by_activation_code(params[:activation_code])
    raise ActiveRecord::RecordNotFound, "No such activation code" if @user.nil?
    
    unless @user.nil?
      @user.activation_code = nil
      @user.save
    end
  end
end
