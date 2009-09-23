class MessagesController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :sent]
  before_filter :authorize, :except => [:new, :create, :sent]
  before_filter :captcha_validation, :only => [:quickping] if APP_CONFIG[:captcha_enable]
  
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  # Save a new computer using given parameters
  def create
    @message = Message.new(params[:message])
    
    if logged_in?
      @message.user_id = current_user.id
      @message.firstname = current_user.firstname unless current_user.firstname.blank?
      @message.lastname = current_user.lastname unless current_user.lastname.blank?
      @message.email = current_user.email unless current_user.email.blank?
    end
    
    @message.user_agent = request.headers["USER_AGENT"]
    
    respond_to do |format|
      if @message.save
        format.html { render :action => "sent", :message => @message}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def sent
    @message = params[:message]
    if @message.user_id.nil?
      @user = nil
    else
      @user = User.find(@message.user_id)
    end
  end
end
