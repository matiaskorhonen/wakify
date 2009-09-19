class ComputersController < ApplicationController
  before_filter :login_required
  
  def index
    @computers = current_user.computers.all
  end

  def show
    @computer = current_user.computers.find(params[:id])
  end

  def new
    @computer = Computer.new
  end

  def edit
    @computer = current_user.computers.find(params[:id])
  end
  
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
  
  def update
    @computer = current_user.computers.find(params[:id])
    @computer.attributes = params[:computer]
    
    respond_to do |format|
      if @cumputer.access_allowed(current_user)
        if @computer.save
          format.html { render :action => "show" }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  def pingorwake
    if params[:commit] == "Wake"
      redirect_to :action => "wake_computer", :controller => "wakeonlan", :id => params[:computer][:id]
    else
      redirect_to :action => "ping_computer", :controller => "ping", :id => params[:computer][:id]
    end
  end
end
