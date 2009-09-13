class PingController < ApplicationController
  def index
  end

  def query
    @host = params[:host_to_ping]
    
    if valid_hostname?(@host)
      @verbose = `ping #{@host} -c 3`
      p = Net::Ping::External.new(@host)
      @result = p.ping
    else
      @verbose = "You entered an invalid hostname"
    end
  end
end
