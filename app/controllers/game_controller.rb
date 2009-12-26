class GameController < ApplicationController

  def atom
    redirect_to :controller => "games", :action => "atom"
  end
end
