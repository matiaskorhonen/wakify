# Copyright (C) 2000-2003  K.Kodama
#
# Modified by Matias Korhonen (26.09.2009: Removed command line options, changed to
# send the magic packet straight to the IP, not the broadcast address)
#
# Licensed under the Ruby License: http://www.ruby-lang.org/en/LICENSE.txt
# and the GNU General Public License: http://www.gnu.org/copyleft/gpl.html
#
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
  
  def wake(options = {})
    mac = options[:mac] ||= "ff:ff:ff:ff:ff:ff"
    address = options[:address] ||= "255.255.255.255"
    port = options[:port] ||= 9
    count = options[:count] || 1
    interval = options[:interval] || 0.01
    
    magicpacket = (0xff.chr)*6+(mac.split(/:/).pack("H*H*H*H*H*H*"))*16
    
    count.times {
      sleep interval
      @socket.send(magicpacket, 0, address, port)
    }
  end
end
