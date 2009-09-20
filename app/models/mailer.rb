# Wakify mailer
#
# Used to send mail to the users
class Mailer < ActionMailer::Base
  # The welcome email sent to users when they join.
  def welcome_email(user)
    recipients    user.email
    from          "#{APP_CONFIG[:sitename]} <notifications@example.com>"
    subject       "Welcome to #{APP_CONFIG[:sitename]}"
    sent_on       Time.now
    content_type  "text/plain"
    body          :user => user
  end
  
  # The password reset email sent to users when requested.
  def password_reset_email(user)
    recipients    user.email
    from          "#{APP_CONFIG[:sitename]} <notifications@example.com>"
    subject       "Password reset for #{APP_CONFIG[:sitename]}"
    sent_on       Time.now
    content_type  "text/plain"
    body          :user => user
  end
end
