class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Mailer.deliver_welcome_email(user)
  end
end 