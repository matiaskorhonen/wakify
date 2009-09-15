class PingController < ApplicationController
  def index
  end

  def query
    if params[:id].nil?
      @host = params[:host_to_ping]
    else
      c = Computer.find(params[:id])
      if c.access_allowed?(current_user)
        @host = c.host
      else
        flash[:error] = "Something went wrong, it seems that you are not allowed to ping that host!"
        redirect_to :action => "index", :controller => "computers"
      end
    end
    
    if valid_hostname?(@host) && !@host.nil?
      @verbose = system_ping(@host)
      p = Net::Ping::External.new(@host)
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
