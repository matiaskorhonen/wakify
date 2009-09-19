# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Authorization
  
  def navigation(*controllers)
    xhtml = "<ul>\n"
    
    controllers.each do |c|
      xhtml << '<li>' + link_to(c["label"], "/" + c["controller"]) + '</li>'
    end
    
    pages = Page.find_all_by_navigation(true)
    
    pages.each do |p|
      xhtml << '<li class="static">' + link_to(p.name, static_path(p.permalink)) + '</li>'
    end
    
    xhtml << "</ul>"
  end
end
