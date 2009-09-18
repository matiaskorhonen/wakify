class Page < ActiveRecord::Base
  attr_accessible :name, :permalink, :content
  
  validates_presence_of :name, :permalink, :content
end
