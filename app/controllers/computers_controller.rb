# Controller used for Computer related actions
class ComputersController < ApplicationController
  before_filter :login_required
  
  # List all computers for the current user
  def index
    @computers = current_user.computers.all
    respond_to do |format|
      format.html
      format.text { render :layout => false }
    end
  end

  # Show a particular computer for the current user
  def show
    @computer = current_user.computers.find(params[:id])
  end

  # Create a new computer
  def new
    @computer = current_user.computers.new
  end

  # Edit an existing computer
  def edit
    @computer = current_user.computers.find(params[:id])
  end
  
  # Save a new computer using given parameters
  def create
    @computer = current_user.computers.new(params[:computer])
    
    respond_to do |format|
      if @computer.save
        flash[:notice] = 'Computer was successfully created.'
        format.html { redirect_to(@computer) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # Update an existing computer using given parameters
  def update
    @computer = current_user.computers.find(params[:id])
    @computer.attributes = params[:computer]
    
    respond_to do |format|
      if @computer.save
        flash[:notice] = "Computer was successfully updated"
        format.html { render :action => "show" }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # Delete a stored computer
  def delete
    @computer = current_user.computers.find(params[:id])
    
    respond_to do |format|
      if @computer.delete
        flash[:notice] = "Computer was successfully deleted"
      else
        flash[:error] = "Something went wrong"
      end
      format.html { redirect_to :controller => "computers", :action => "index" }
    end
  end
  
  # Ping or wake an existing computer
  def pingorwake
    if params[:commit] == "Wake"
      redirect_to :action => "wake_computer", :controller => "wakeonlan", :id => params[:computer][:id]
    else
      redirect_to :action => "ping_computer", :controller => "ping", :id => params[:computer][:id]
    end
  end
end
