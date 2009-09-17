class ComputersController < ApplicationController
  before_filter :login_required
  
  def index
    @computers = Computer.find_all_by_user_id(session[:user_id])
    @links = [{"uri" => "/computers/new", "label" => "Create"}]
  end

  def show
    @computer = Computer.find(params[:id])
    @links = [{"uri" => "/computers", "label" => "List"}, {"uri" => "/computers/new", "label" => "Create"}, {"uri" => "/computers/edit/" + params[:id], "label" => "Edit" }]
  end

  def new
    @computer = Computer.new
    @links = [{"uri" => "/computers", "label" => "List"}]
  end

  def edit
    @computer = Computer.find(params[:id])
    @links = [{"uri" => "/computers", "label" => "List"}, {"uri" => "/computers/new", "label" => "Create"}]
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
    if params[:commit] == "Wake"
      redirect_to :action => "wake", :controller => "wakeonlan", :id => params[:computer][:id]
    else
      redirect_to :action => "query", :controller => "ping", :id => params[:computer][:id]
    end
  end
end
