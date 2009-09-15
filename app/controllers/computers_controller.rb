class ComputersController < ApplicationController
  before_filter :login_required
  
  def index
    @computers = Computer.find_all_by_user_id(session[:user_id])
  end

  def show
    @computer = Computer.find(params[:id])
  end

  def new
    @computer = Computer.new
  end

  def edit
    @computer = Computer.find(params[:id])
  end
  
  def create
    @computer = Computer.new(params[:computer])
    @computer.user_id = session[:user_id]
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
    @computer = Computer.find(params[:id])
    @computer.attributes = params[:computer]
    
    respond_to do |format|
      if @computer.save
        format.html { render :action => "show" }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def pingorwake
    @computer = Computer.find(params[:computer][:id])

    if params[:submit] == "Wake"
      redirect_to :action => "wake", :controller => "wakeonlan"
    else
      redirect_to :action => "query", :controller => "ping"
    end
  end
end
