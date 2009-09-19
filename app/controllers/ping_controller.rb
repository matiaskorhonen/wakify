class PingController < ApplicationController
  def index
  end
  
  def quickping
    @host_to_ping = params[:host_to_ping]
    
    if valid_hostname?(@host_to_ping) && !@host_to_ping.nil?
      @verbose = system_ping(@host_to_ping)
      p = Net::Ping::External.new(@host_to_ping)
      @result = p.ping
    else
      flash[:error] = "You entered an invalid hostname."
      redirect_to :action => "index"
    end
  end
  
  def ping_computer
    c = current_user.computers.find(params[:id])
    if c.access_allowed?(current_user)
      status = Net::Ping::External.new(c.host) ? "up" : "down"
      flash[:notice] = "<p>The host is #{status}.</p><pre>#{system_ping(c.host)}</pre>"
    else
      flash[:error] = "Something went wrong, it seems that you are not allowed to ping that host!"
    end
    
    redirect_to request.referer
  end
  
protected

  def system_ping(host = "127.0.0.1", count = 3, command = APP_CONFIG[:ping_command])
    return `#{command} #{host} -c #{count}`
  end
end