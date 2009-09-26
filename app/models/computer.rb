# Computer records require:
# * name
# * host
# * mac
# * port
#
# The *description* is optional
class Computer < ActiveRecord::Base
  require 'resolv'
  require 'ipaddr'
  
  belongs_to :user
  
  validates_presence_of :name, :host, :mac, :port
  validates_format_of   :mac,
                        :with =>  /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/ ,
                        :message => "invalid"
  validates_format_of   :host,
                        :with => /(^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$)|(^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$)/,
                        :message => "invalid"
  validates_numericality_of :port
  
  validate :hostname_validations
  
  # Check if the host resolves, or if the host is an IP address, check that it is not in the private ranges.
  def hostname_validations
    if /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/.match(self.host)
      errors.add_to_base("You cannot enter a private IP address") if private_ip?(self.host)
    else
      errors.add_to_base("Your hostname did not resolve") unless hostname_resolves?(self.host)
    end
  end
  
  # Test if a given IP address is in the private ranges:
  #
  # * <b>24-bit Block</b> 10.0.0.0 to 10.255.255.255
  # * <b>20-bit Block</b> 172.16.0.0 to 172.31.255.255
  # * <b>16-bit Block</b> 192.168.0.0 to 192.168.255.255
  #
  # Requires an IP address as a string.
  def private_ip?(ip)
    private_ranges = [IPAddr.new("10.0.0.0/8"), IPAddr.new("172.16.0.0/12"), IPAddr.new("192.168.0.0/16")]
    result = false
    
    private_ranges.each do |range|
      result = range.include?(IPAddr.new(ip))
      break if result
    end
    
    return result
  end
  
  # Try and resolve a given hostname.
  # Returns the IP if successful and nil if not.
  def resolve_hostname(hostname)
    r = Resolv::DNS.new
    
    return r.getaddress(hostname).to_s
  rescue Resolv::ResolvError
    return nil
  end
  
  # Check if a hostname resolves or not.
  # Returns a boolean
  def hostname_resolves?(hostname)
    return !resolve_hostname(hostname).nil?
  end
  
  # This is for creating pretty, SEO URLs.
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
end
