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
	end;
	def close; @socket.close; @socket=""; end
	def wake(mac_addr, ip = "255.255.255.255", port = 9, count = 3)
		wol_magic=(0xff.chr)*6+(mac_addr.split(/:/).pack("H*H*H*H*H*H*"))*16
		count.times{ @socket.send(wol_magic, 0, ip, port) }
	end
end

if $0 == __FILE__
=begin
Sample for WakeOnLan class.
Use as: ruby wakeonlan.rb [broadcast_address] < data_text
line format of data_text: ip-address  hostname  MAC-address
Data sample: 10.20.30.40  wake-pc  100:110:120:130:140:150
Note.  To check WOL packet, use tcpdump -x.
=end

	if ARGV.size>=1; broadcast=ARGV[0]; ARGV.clear; else broadcast=""; end
	wol=WakeOnLan.new
	while gets
		ip,name,hw=$_.sub(/^\s+/,"").split(/\s+/)
		wol.wake(hw, broadcast, ip)
	end
	wol.close
end
