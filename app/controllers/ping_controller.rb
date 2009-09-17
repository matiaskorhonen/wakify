class PingController < ApplicationController
  def index
  end

  def query
    id = params[:id]
    @host_to_ping = params[:host_to_ping]
    
    if !id.nil? && @host_to_ping.nil?
      c = Computer.find(id)
      
      if c.access_allowed?(current_user) && !c.nil?
        @host_to_ping = c.host
      else
        flash[:error] = "Something went wrong, it seems that you are not allowed to ping that host!"
        redirect_to :action => "index", :controller => "computers"
      end
    end
    
    if valid_hostname?(@host_to_ping) && !@host_to_ping.nil?
      @verbose = system_ping(@host_to_ping)
      p = Net::Ping::External.new(@host_to_ping)
      @result = p.ping
    else
      @verbose = "You entered an invalid hostname"
    end
  end
  
protected

  def system_ping(host = "127.0.0.1", count = 3, command = "ping")
    return `#{command} #{host} -c #{count}`
  end
end
