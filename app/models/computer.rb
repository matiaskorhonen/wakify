class Computer < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name, :host, :mac, :port
  validates_format_of   :mac,
                        :with =>  /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/ ,
                        :message => "invalid"
  validates_format_of   :host,
                        :with => /(^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$)|(^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$)/,
                        :message => "invalid"
  validates_numericality_of :port
end
