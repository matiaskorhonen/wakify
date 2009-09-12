class Computer < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name, :host, :mac
  validates_format_of :mac ,
                     :with =>  /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/ ,
                     :message => "Invalid"
end
