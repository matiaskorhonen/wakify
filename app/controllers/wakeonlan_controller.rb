class WakeonlanController < ApplicationController
  before_filter :quickwake_validation, :only => [:quickwake]
  before_filter :captcha_validation, :only => [:quickwake] if APP_CONFIG[:captcha_enabled]
  
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
    
    flash[:notice] = wakehost(c.mac, c.host, c.port)
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
