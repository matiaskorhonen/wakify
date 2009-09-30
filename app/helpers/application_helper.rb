# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Construct Captcha tags for a form
  def captcha_tags
    c = Captcha.new(APP_CONFIG[:captcha_salt], APP_CONFIG[:captcha_lower_limit], APP_CONFIG[:captcha_upper_limit])
    qa = c.generate_qa
    
    xhtml = label_tag("captcha_attempt", qa[:question])
    xhtml << "<br />"
    xhtml << password_field_tag("captcha_attempt")
    xhtml << hidden_field_tag("hashed_answer", qa[:hashed_answer])
  end
  
  # Safe textile helper.
  # Removes unwanted tags (like divs) from the output
  def safe_textilize(text)
    if text && text.respond_to?(:to_s)
      doc = RedCloth.new( text.to_s )
      doc.sanitize_html = true
      doc.to_html
    end
  end
  
  def adsense(options)
    ad_client = options[:client]
    ad_slot = options[:slot]
    width = options[:width]
    height = options[:height]
    
    return String.new(%{
      <script type="text/javascript"><!--
        google_ad_client = \"#{ad_client}\";
        google_ad_slot = \"#{ad_slot}\";
        google_ad_width = #{width};
        google_ad_height = #{height};
        //-->
        </script>
        <script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\">
      </script>})
  end
end