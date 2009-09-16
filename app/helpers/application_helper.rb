# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Authorization
  
  def navigation(*controllers)
    xhtml = "<ul>\n"
    
    controllers.each do |controller|
      xhtml << "\t<li>" + link_to(controller.capitalize, "/#{controller}") + "</li>\n"
    end
    
    xhtml << "</ul>"
  end
end
