class Computer < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name, :host, :mac
  validates_format_of   :mac,
                        :with =>  /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/ ,
                        :message => "invalid"
  validates_format_of   :broadcast_ip,
                        :with => /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})?$/,
                        :message => "invalid"
end
