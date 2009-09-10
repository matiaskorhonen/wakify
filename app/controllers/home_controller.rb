class HomeController < ApplicationController
  def index
  end
  
  def wake
    @result = quickwake(params[:mac], params[:ip])
  end

end
