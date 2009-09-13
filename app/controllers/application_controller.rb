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
  
  def system_ping(host = "127.0.0.1", count = 3, command = "ping")
    return `#{command} #{host} -c #{count}`
  end
  
  def system_wol(host = "127.0.0.1", mac = "", port = 9, command = "wakeonlan")
    return `#{command} -p #{port} -i #{host} #{mac}`
  end

  def valid_hostname?(address)
    address.to_s.chars.each { |character| return false unless ALLOWED_CHARS.include?(character) }
    return true
  end
end
