class WakeonlanController < ApplicationController
  def index
  end

  def wake
    @mac = params[:mac]
    @host_to_wake = params[:host_to_wake]
    
    @result = quickwake(@mac, @host_to_wake)
  end

end
