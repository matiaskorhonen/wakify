Given /^that the user opens the WakeOnLan page$/ do
  visit "/wakeonlan"
  response.body.should =~ /Send Magic Packet/m
end
