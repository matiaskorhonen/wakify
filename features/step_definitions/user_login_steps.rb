Given /^a user is logged in as "(.*)"$/ do |login|
  @current_user = User.create!(
    :username => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )

  @current_user.activation_code = nil
  @current_user.save!

  visit "/login" 
  fill_in("login", :with => login) 
  fill_in("password", :with => 'generic') 
  click_button("Log in")
  response.body.should =~ /Logged/m  
end