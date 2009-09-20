# User Observer for the welcome email
class UserObserver < ActiveRecord::Observer
  
  # Send the welcome email after the user has signed up.
  def after_create(user)
    Mailer.deliver_welcome_email(user)
  end
end 