class TableController < ApplicationController
  layout "games"

  def index
    render :action => "status"
  end
  
  def status
    
  end
end
