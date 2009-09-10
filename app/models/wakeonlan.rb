# K.Kodama 2003-04-20 revised/bug fix
# K.Kodama 2000-05-10
# This program is distributed freely 
# in the sense of GNU General Public License or ruby's.
#
# Source: http://www.math.kobe-u.ac.jp/~kodama/tips-WakeOnLAN.html

require "socket"

class WakeOnLan
	attr :socket
	def initialize
		@socket=UDPSocket.open()
		@socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST,1)
	end;
	def close; @socket.close; @socket=""; end
	def wake(mac_addr, broadcast="", ip_addr="")
		wol_magic=(0xff.chr)*6+(mac_addr.split(/:/).pack("H*H*H*H*H*H*"))*16
		if broadcast==""; # Set broadcast. Assume that standard IP-class.
			ips=ip_addr.split(/\./);c=ips[0].to_i
			if c<=127; ips[1]="255";end # class A:1--127
			if c<=191; ips[2]="255";end # class B:128--191
			if c<=223; ips[3]="255";end # class C:192--223
			# class D:224--239 multicast
			broadcast=ips.join(".")
		end
		3.times{ @socket.send(wol_magic,0,broadcast,"discard") }
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
