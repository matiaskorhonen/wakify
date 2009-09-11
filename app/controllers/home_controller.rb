class HomeController < ApplicationController
  def index
  end
  
  def wake
    @mac = params[:mac]
    @ip = params[:ip]
    
    @result = quickwake(@mac, @ip)
  end

end
