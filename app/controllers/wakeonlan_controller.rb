class WakeonlanController < ApplicationController
  def index
  end

  def quickwake
    @mac = params[:mac]
    @host_to_wake = params[:host_to_wake]
    @port = params[:port].to_i ||= APP_CONFIG[:wol_port]
    
    if @mac.empty? || @host_to_wake.empty? || !valid_hostname?(@host_to_wake)
      flash[:error] = "You should enter a valid hostname or IP address"
      redirect_to :action => "index"
    else
      @result = wakehost(@mac, @host_to_wake, @port)
    end
  end
  
  def wake_computer
    c = Computer.find(params[:id])
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
end
