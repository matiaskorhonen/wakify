class SitemapController < ApplicationController
  def index
    @pages = Page.find_all_by_navigation(true)
    
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
end
