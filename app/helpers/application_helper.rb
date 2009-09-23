# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Construct the navigation ul
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
  
  # Construct Captcha tags for a form
  def captcha_tags
    c = Captcha.new(APP_CONFIG[:captcha_lower_limit], APP_CONFIG[:captcha_upper_limit])
    qa = c.generate_qa(APP_CONFIG[:captcha_password], APP_CONFIG[:captcha_salt])
    
    xhtml = label_tag("captcha_attempt", qa["question"])
    xhtml << "<br />"
    xhtml << password_field_tag("captcha_attempt")
    xhtml << hidden_field_tag("encrypted_answer", qa["encrypted_answer"])
  end
  
  def safe_textilize(text)
    if text && text.respond_to?(:to_s)
      doc = RedCloth.new( text.to_s )
      doc.sanitize_html = true
      doc.to_html
    end
  end
end