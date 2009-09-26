# Controller for pinging hosts
class PingController < ApplicationController
  before_filter :quickping_validation, :only => [:quickping]
  before_filter :captcha_validation, :only => [:quickping] if APP_CONFIG[:captcha_enabled]
  
  # Allow the user to ping a host which has not been saved as a computer
  def index
  end
  
  # Ping a host that has not been saved as a Computer, and display the results to the user
  def quickping
    @host_to_ping = params[:host_to_ping]
    
    @verbose = system_ping(@host_to_ping)
    p = Net::Ping::External.new(@host_to_ping)
    @result = p.ping
  end
  
  # Ping a stored Computer and display the results in a flash notice.
  def ping_computer
    c = current_user.computers.find(params[:id])
    
    status = Net::Ping::External.new(c.host) ? "up" : "down"
    flash[:notice] = "<p>The host is #{status}.</p><pre>#{system_ping(c.host)}</pre>"
    
    redirect_to request.referer
  end
  
protected

  # Use the system ping to ping a host
  def system_ping(host = "127.0.0.1", count = 3, command = APP_CONFIG[:ping_command])
    return `#{command} #{host} -c #{count}`
  end
  
  # Validate that the given host is properly formatted.
  def quickping_validation
    valid_hostname = valid_hostname?(params[:host_to_ping])
    
    if !valid_hostname
      flash[:error] = "You need to enter a valid host!"
      redirect_to :controller => "ping", :action => "index"
    end
  end
end