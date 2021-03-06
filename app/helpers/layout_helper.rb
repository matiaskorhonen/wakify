# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  # Set the page title
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  # Construct the navigation
  def navigation(*controllers)
    xhtml = "<ul>\n"
    
    controllers.each do |c|
      xhtml << '<li>' + link_to(c[:label] ||= c[:controller].capitalize, "/" + c[:controller]) + '</li>'
    end
    
    pages = Page.find_all_by_navigation(true)
    
    pages.each do |p|
      xhtml << '<li class="static">' + link_to(p.name, static_path(p.permalink)) + '</li>'
    end
    
    xhtml << "</ul>"
    xhtml.html_safe
  end
end
