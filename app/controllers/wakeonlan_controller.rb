class WakeonlanController < ApplicationController
  require 'wakeonlan'
  def index
  end

  def wake
    if params[:computer].nil?
      @mac = params[:mac]
      @host_to_wake = params[:host_to_wake]
    else
      @mac = params[:computer][:mac]
      @host_to_wake = params[:computer][:host]
    end
    
    @result = quickwake(@mac, @host_to_wake)
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
