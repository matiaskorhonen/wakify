class WakeonlanController < ApplicationController
  require 'wakeonlan'
  
  def index
  end

  def wake
    if params[:id].nil?
      @mac = params[:mac]
      @host_to_wake = params[:host_to_wake]
      @result = quickwake(@mac, @host_to_wake)
    else
      c = Computer.find(params[:id])
      if c.access_allowed?(current_user)
        @mac = c.mac
        @host_to_wake = c.host
        @result = quickwake(@mac, @host_to_wake)
      else
        flash[:error] = "Something went wrong, it seems that you are not allowed to wake that host!"
        redirect_to :action => "index", :controller => "computers"
      end
    end
  end

protected

  def quickwake(mac, host)
    wol = WakeOnLan.new
    return wol.wake(mac, "255.255.255.255", host)
  end
  
  def system_wol(host = "127.0.0.1", mac = "", port = 9, command = "wakeonlan")
    return `#{command} -p #{port} -i #{host} #{mac}`
  end
end
