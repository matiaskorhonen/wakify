class WakeonlanController < ApplicationController
  before_filter :quickwake_validation, :only => [:quickwake]
  before_filter :captcha_validation, :only => [:quickwake]
  
  def index
  end

  def quickwake
    @mac = params[:mac]
    @host_to_wake = params[:host_to_wake]
    @port = params[:port].to_i ||= APP_CONFIG[:wol_port]
    
    @result = wakehost(@mac, @host_to_wake, @port)
  end
  
  def wake_computer
    c = current_user.computers.find(params[:id])
    if c.access_allowed?(current_user)
      flash[:notice] = wakehost(c.mac, c.host, c.port)
    else
      flash[:error] = "Something went wrong, it seems that you are not allowed to wake that host!"
    end
    
    redirect_to request.referer
  end

protected

  def wakehost(mac, host, port=APP_CONFIG[:wol_port], command = APP_CONFIG[:wol_command])
    return `#{command} -p #{port} -i #{host} #{mac}`
  end
  
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
