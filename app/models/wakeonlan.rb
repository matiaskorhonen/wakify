# K.Kodama 2003-04-20 revised/bug fix
# K.Kodama 2000-05-10
# This program is distributed freely 
# in the sense of GNU General Public License or ruby's.

require "socket"

class WakeOnLan
  attr :socket
  def initialize
    @socket=UDPSocket.open()
    @socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST,1)
  end
  def close
    @socket.close
    @socket=""
  end
  def wake(mac_addr, ip = "255.255.255.255", port = 9, count = 3)
    wol_magic=(0xff.chr)*6+(mac_addr.split(/:/).pack("H*H*H*H*H*H*"))*16
    count.times{ @socket.send(wol_magic, 0, ip, port) }
  end
end
