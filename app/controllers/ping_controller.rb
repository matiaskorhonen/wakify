class PingController < ApplicationController
  def index
  end

  def query
    @host = params[:host]
    
    p = Net::Ping::External.new(@host)
    @result = p.ping
  end
end
