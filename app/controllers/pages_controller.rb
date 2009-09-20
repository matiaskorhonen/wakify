# Controller used for Pages related actions
class PagesController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  before_filter :authorize, :except => [:show, :index]
  
  # List all pages
  def index
    @pages = Page.all
  end
  
  # Show a specific page using either the id or the permalink
  def show
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, "Page not found" if @page.nil?
    else
      @page = Page.find(params[:id])
    end
  end
  
  # Create a new page
  def new
    @page = Page.new
  end
  
  #Save a new page in the database
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  # Edit an existing page
  def edit
    @page = Page.find(params[:id])
  end
  
  # Update an existing page
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  # Destroy a given page
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
end
