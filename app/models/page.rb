# Static pages model.  Used for pages such as about, FAQs, etc...
#
# All attributes are required, excluding the *navigation* attribute.
#
# The navigation attribute defines whether the page will be included in the main menu.
class Page < ActiveRecord::Base
  attr_accessible :name, :permalink, :content, :navigation
  
  validates_presence_of :name, :permalink, :content
end
