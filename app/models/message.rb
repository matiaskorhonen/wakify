class Message < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :user_id, :user_agent, :subject, :message
  
  validates_presence_of :firstname, :lastname, :email, :message, :subject
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_uniqueness_of :message, :scope => [:firstname, :lastname, :subject], :message => "has already been sent once"
  
  def to_param
    "#{self.id}-#{self.subject.parameterize}"
  end
  
  def fullname
    return self.firstname + " " + self.lastname
  end
end