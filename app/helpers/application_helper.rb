# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Authorization
  
  def navigation(*controllers)
    xhtml = "<ul>\n"
    
    controllers.each do |c|
      
      xhtml << "\t<li>" + link_to(c["label"], "/" + c["controller"]) + "</li>\n"
    end
    
    xhtml << "</ul>"
  end
end
