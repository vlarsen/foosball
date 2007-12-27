class PlayersController < ApplicationController
  layout "games"
  
  def list
    @players = Player.rated_players
  end
  
  def team_list
    @players = Player.find(:all, :order => "team_rating DESC")
    @players.delete_if {|player| player.total_team_games < 1 }
    render(:layout => "team_games")
  end
  
  def expected_score
    @all_players = []
    @ratings = Hash.new
    Player.find(:all, :order => "name").each do |p|
      @all_players << p.name
      @ratings[p.name] = p.rating
    end

    @expected = Hash.new { |h,k| h[k] = Hash.new }
    @all_players.each do |player1|
      @all_players.each do |player2|
        @expected[player1][player2] = RatingHelper::get_expected_scores_from_ratings(@ratings[player1], @ratings[player2])
      end
    end
    render(:layout => "games")
    
  end
end
