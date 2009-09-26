require 'rubygems'
require 'markup_validity'

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Pages index view" do
  before(:each) do
    render 'pages/index', :layout => 'application'
  end

  #Validate xhtml
  it "should be valid xhtml strict" do
    response.body.should be_xhtml_strict
  end
end
