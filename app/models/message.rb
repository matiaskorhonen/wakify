# The Message model is for messages sent by users to the site maintainer using the contact form.
# The following attributes are required:
# * firstname
# * lastname
# * email
# * message
# * subject
#
# The user_id attribute should be filled if the sender has loggend into the site.
# There is no actual relationship between the User model and the message model because users don't have to be logged in to send messages.
class Message < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :user_id, :user_agent, :subject, :message
  
  validates_presence_of :firstname, :lastname, :email, :message, :subject
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_uniqueness_of :message, :scope => [:firstname, :lastname, :subject], :message => "has already been sent once"
  
  # This is for creating pretty, SEO URLs.
  def to_param
    "#{self.id}-#{self.subject.parameterize}"
  end
  
  # Return the fullname of the sender.
  def fullname
    return self.firstname + " " + self.lastname
  end
end