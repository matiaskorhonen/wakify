Given /^that the user opens the ping page$/ do
  visit "/ping"
  response.body.should =~ /Host to ping/m
end