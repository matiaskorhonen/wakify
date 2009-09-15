class PingController < ApplicationController
  def index
  end

  def query
    if params[:computer].nil?
      @host = params[:host_to_ping]
    else
      @host = params[:computer][:host]
    end
    
    if valid_hostname?(@host)
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
