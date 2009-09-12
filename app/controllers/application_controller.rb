# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  require 'wakeonlan'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def quickwake(mac, host)
    wol = WakeOnLan.new
    return wol.wake(mac, "255.255.255.255", host)
  end

  def valid_hostname?(address)
    address.to_s.chars.each { |character| return false unless ALLOWED_CHARS.include?(character) }
    return true    
  end
end
