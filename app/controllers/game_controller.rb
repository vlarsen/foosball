class GameController < ApplicationController

  session :off, :only => :atom

  def atom
    redirect_to :controller => "games", :action => "atom"
  end
end
