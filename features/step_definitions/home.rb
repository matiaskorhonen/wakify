Given /^that there is a home page$/ do
  visit "/home"
  response.code.should == "200"
end

Then /^users should be able to view it$/ do
  visit "/home"
  response.body.should =~ /Home/m
end