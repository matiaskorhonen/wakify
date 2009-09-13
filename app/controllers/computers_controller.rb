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
end
