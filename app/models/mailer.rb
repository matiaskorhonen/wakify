class Mailer < ActionMailer::Base
  def welcome_email(user)
    recipients    user.email
    from          "#{APP_CONFIG[:sitename]} <notifications@example.com>"
    subject       "Welcome to #{APP_CONFIG[:sitename]}"
    sent_on       Time.now
    content_type  "text/plain"
    body          :user => user
  end
end
