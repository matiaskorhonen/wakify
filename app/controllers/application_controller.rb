# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  require 'captcha'
  include Authentication
  helper :all
  protect_from_forgery
  
  helper_method :admin?
  
  protected
  
  # Check if the current user is an administrator
  def admin?
    if !logged_in?
      return false
    else
      return current_user.admin?
    end
  end
  
  # Check if the current user is an admin, and if not redirect them back to :root with an error message.
  def authorize
    unless admin?
      flash[:error] = "Unauthorized access attempted."
      redirect_to :root
      false
    end
  end

  # Check if a hostname is valid.
  def valid_hostname?(address)
    hostname_regex = /(^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$)|(^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$)/
    return hostname_regex.match(address)
  end
  
  # Check if a MAC address is valid.
  def valid_mac?(mac)
    mac_regex = /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/
    return mac_regex.match(mac)
  end
  
  # Check if a captcha validates
  #
  # Requires that the following parameters be set:
  # * :encrypted_answer
  # * :captcha_attempt
  #
  # Also *captcha_attempt* and *captcha_salt* have to be set in the configuration file.
  def captcha_validation
    c = Captcha.new
    success = c.check_answer(params[:encrypted_answer], params[:captcha_attempt], APP_CONFIG[:captcha_password], APP_CONFIG[:captcha_salt])
    if !success
      flash[:error] = "Failed CAPTCHA! Remember to answer as a number (i.e. '6', not 'six')"
      respond_to do |format|
        format.html { redirect_to request.referer }
      end
    end
  end
end
