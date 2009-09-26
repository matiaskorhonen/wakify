# Controllor for Message related actions and views.
class MessagesController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :sent]
  before_filter :authorize, :except => [:new, :create, :sent]
  before_filter :captcha_validation, :only => [:create] if APP_CONFIG[:captcha_enabled]
  
  # List all messages, only available to to admins
  def index
    @messages = Message.all
  end

  # Show a particular message, only available to admins
  def show
    @message = Message.find(params[:id])
  end

  # View for creating and sending new messages
  def new
    @message = Message.new
  end

  # Create a new message in the system
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
  
  # View for displaying a confirmation for the user that their message was sent.
  def sent
    @message = params[:message]
    if @message.user_id.nil?
      @user = nil
    else
      @user = User.find(@message.user_id)
    end
  end
end
