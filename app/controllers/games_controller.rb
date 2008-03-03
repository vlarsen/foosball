class GamesController < ApplicationController

  layout "games", :except => [ :atom, :csv, :versus_graph ]
  session :off, :only => [ :atom, :csv, :versus_graph ]

  def index
    list
    render :action => 'list'
  end
  
  def csv
    headers["Content-Type"] = "text/plain"
    @games = Game.find(:all, :order => "played_at asc")
  end
  
  def versus_graph
    @versus_limit = 10
    headers["Content-Type"] = "text/plain"
    @games = Game.find(:all, :order => "played_at ASC")
    @versus = Hash.new { |h,k| h[k] = Hash.new {|h2,k2| h2[k2] = 0} }
    @games.each do |g|
      @versus[g.red][g.blue] += 1
      @versus[g.blue][g.red] += 1
    end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    options = { :page => params[:page], :order => "played_at desc" }
    if params.has_key?(:id)
      options[:conditions] = "blue = '#{params[:id]}' or red = '#{params[:id]}'"
      @for_player = params[:id]
    end
    if params.has_key?(:playera) && params.has_key?(:playerb)
      options[:conditions] = "(blue='#{params[:playera]}' and red='#{params[:playerb]}') or (red='#{params[:playera]}' and blue='#{params[:playerb]}')"
      @for_player = "#{params[:playera]} vs #{params[:playerb]}"
    end

    @games = Game.paginate options
    
    @players = Player.rated_players
  end

  def atom
    @games = Game.find(:all,
                       :conditions => ["played_at >= ?", 7.days.ago],
                       :order => "played_at desc")
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    unless @game.valid?
      render :action => 'new'
      return
    end
    
    @game.add_to_players

    flash[:notice] = 'Game was successfully created.'
    redirect_to :action => 'list'
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    update_id = params[:id]
    affected_games = Game.find(:all, :conditions => "id >= #{update_id}", :order => "id ASC")
    affected_games.each do |g|
      g.subtract_from_players
    end
    
    @game = Game.find(params[:id])
    
    if @game.update_attributes(params[:game])
      affected_games = Game.find(:all, :conditions => "id >= #{update_id}", :order => "id ASC")
      affected_games.each do |g|
        g.add_to_players
      end
      
      flash[:notice] = "#{affected_games.length} game#{affected_games.length > 1 ? "s" : ""} was successfully updated."
      redirect_to :action => 'show', :id => @game
    else
      render :action => 'edit'
    end
  end

  def destroy
    destroy_id = params[:id]

    affected_games = Game.find(:all, :conditions => "id >= #{destroy_id}")
    affected_games.each do |g|
      g.subtract_from_players
    end
    @game = Game.find(params[:id])

    @game.destroy

    affected_games = Game.find(:all, :conditions => "id >= #{destroy_id}")
    affected_games.each do |g|
      g.add_to_players
    end
    
    redirect_to :action => 'list'
  end
end
