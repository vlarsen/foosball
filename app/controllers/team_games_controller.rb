class TeamGamesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @team_games = TeamGame.paginate :page => params[:page], :order => "played_at desc"
  end

  def show
    @team_game = TeamGame.find(params[:id])
  end

  def new
    @team_game = TeamGame.new
  end

  def create
    @team_game = TeamGame.new(params[:team_game])
    unless @team_game.valid?
      render :action => 'new'
      return
    end

    @team_game.add_to_players
    
    flash[:notice] = 'TeamGame was successfully created.'
    redirect_to :action => 'list'
  end

  def edit
    @team_game = TeamGame.find(params[:id])
  end

  def update
    update_id = params[:id]
    affected_games = TeamGame.find(:all, :conditions => "id >= #{update_id}", :order => "id ASC")
    affected_games.each do |g|
      g.subtract_from_players
    end
    
    @team_game = TeamGame.find(params[:id])

    if @team_game.update_attributes(params[:team_game])
      affected_games = TeamGame.find(:all, :conditions => "id >= #{update_id}", :order => "id ASC")
      affected_games.each do |g|
        g.add_to_players
      end

      flash[:notice] = "#{affected_games.length} team game#{affected_games.length > 1 ? "s" : ""} was successfully updated."
      redirect_to :action => 'show', :id => @team_game
    else
      render :action => 'edit'
    end
  end

  def destroy
    destroy_id = params[:id]

    affected_games = TeamGame.find(:all, :conditions => "id >= #{destroy_id}")
    affected_games.each do |g|
      g.subtract_from_players
    end

    TeamGame.find(params[:id]).destroy

    affected_games = TeamGame.find(:all, :conditions => "id >= #{destroy_id}")
    affected_games.each do |g|
      g.add_to_players
    end

    redirect_to :action => 'list'
  end
end
