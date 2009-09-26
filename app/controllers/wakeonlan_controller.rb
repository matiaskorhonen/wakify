# Controller for waking hosts
class WakeonlanController < ApplicationController
  before_filter :quickwake_validation, :only => [:quickwake]
  before_filter :captcha_validation, :only => [:quickwake] if APP_CONFIG[:captcha_enabled]
  
  # Allow the user to wake a host which has not been saved as a computer
  def index
  end

  # Wake a host that has not been saved as a Computer, and display the result to the user
  def quickwake
    @mac = params[:mac]
    @host_to_wake = params[:host_to_wake]
    @port = params[:port].to_i ||= APP_CONFIG[:wol_port]
    
    @result = wakehost(@mac, @host_to_wake, @port)
  end
  
  # Wake a stored Computer and display the result in a flash notice.
  def wake_computer
    c = current_user.computers.find(params[:id])
    
    flash[:notice] = wakehost(c.mac, c.host, c.port)
    redirect_to request.referer
  end

protected

  # Use the system wakeonlan command to send a MagicPacket
  def wakehost(mac, host, port=APP_CONFIG[:wol_port], command = APP_CONFIG[:wol_command])
    return `#{command} -p #{port} -i #{host} #{mac}`
  end
  
  # Validate that the given host and mac addresses are properly formatted.
  def quickwake_validation
    valid_mac = valid_mac?(params[:mac])
    valid_hostname = valid_hostname?(params[:host_to_wake])
    
    if !valid_mac || !valid_hostname
      flash[:error] = "You need to enter a valid host and MAC address!"
      respond_to do |format|
        format.html { redirect_to :controller => "wakeonlan" }
      end
    end
  end
end
