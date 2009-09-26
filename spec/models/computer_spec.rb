require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Computer do
  before(:each) do
    @valid_attributes = {
      :name => "Test",
      :host => "example.com",
      :mac => "00:08:a1:a9:58:f5",
      :port => 9
    }
    @user_attributes = {
      :firstname => "Joe",
      :lastname => "Doe",
      :username => "johnDoe",
      :email => "joe@doe.com",
      :password => "test1234",
      :password_confirmation => "test1234"
    }
  end

  it "should create a new instance given valid attributes" do
    u = User.create!(@user_attributes)
    u.computers.create!(@valid_attributes)
  end
end
