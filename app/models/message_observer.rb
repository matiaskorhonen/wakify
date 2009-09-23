# Message Observer for the contact form
class MessageObserver < ActiveRecord::Observer
  
  # Send the message after it has been successfully created
  def after_create(message)
    if message.user_id.nil?
      user = nil
    else
      user = User.find(message.user_id)
    end
    
    Mailer.deliver_user_message(message, user)
  end
end 