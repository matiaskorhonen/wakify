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

Then /^the user should be able to add a computer$/ do
  visit "/computers/new"
  fill_in("computer_name", :with => 'Generic Computer')
  fill_in("computer_host", :with => 'example.com')
  fill_in("computer_port", :with => '9')
  fill_in("computer_mac", :with => '00:1d:60:56:71:7e')
  fill_in("computer_description", :with => 'A new computer')
  click_button("Create")
  response.body.should =~ /created/m
end

Given /^a computer named "([^\"]*)" has been added$/ do |name|
  @computer = Computer.create!(
    :name => name,
    :host => 'example.com',
    :port => 9,
    :mac => '00:1d:60:56:71:7e',
    :description => 'A test computer',
    :user_id => User.last.id
  )
  
  @computer.save!
end

Then /^the user should be able to view a list of computers$/ do
 visit "/computers"
 response.body.should =~ /example.com/m
end
