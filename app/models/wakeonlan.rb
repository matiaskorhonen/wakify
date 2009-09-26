# Copyright (C) 2000-2003  K.Kodama
# Original: http://www.math.kobe-u.ac.jp/~kodama/tips-WakeOnLAN.html
#
# Modified by Matias Korhonen (26.09.2009: Removed command line options, changed to
# send the magic packet straight to the IP, not the broadcast address)
#
# Licensed under the Ruby License: http://www.ruby-lang.org/en/LICENSE.txt
# and the GNU General Public License: http://www.gnu.org/copyleft/gpl.html
#
require "socket"

# Ruby version of the WakeOnLan command.  Originally written by K.Kodama.
class WakeOnLan
  attr :socket
  
  # Create a new instance. No arguments required.
  def initialize
    @socket=UDPSocket.open()
    @socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST,1)
  end
  
  # Close the socket opened by WakeOnLan initialization
  def close
    @socket.close
    @socket=""
  end
  
  # Wake a host.
  #
  # == Options
  # * <tt>:mac => "ff:ff:ff:ff:ff:ff"</tt> - Specify the destination MAC Address. Defaults to the broadcast MAC, "ff:ff:ff:ff:ff:ff"
  # * <tt>:address => "255.255.255.255"</tt> - Specify the destination address.  Either a IP or hostname.  Defaults to "255.255.255.255"
  # * <tt>:port => 9</tt> - The destination port. Defaults to the discard port, 9
  # * <tt>:count => 1</tt> - How many time to send the MagicPacket.  Defaults to 1
  # * <tt>:interval => 0.01</tt> - How many seconds to wait between sending packets. Defaults to 0.01
  def wake(options = {})
    mac = options[:mac] ||= "ff:ff:ff:ff:ff:ff"
    address = options[:address] ||= "255.255.255.255"
    port = options[:port] ||= 9
    count = options[:count] || 1
    interval = options[:interval] || 0.01
    
    magicpacket = (0xff.chr)*6+(mac.split(/:/).pack("H*H*H*H*H*H*"))*16
    
    count.times {
      sleep interval if interval > 0
      @socket.send(magicpacket, 0, address, port)
    }
  end
end
