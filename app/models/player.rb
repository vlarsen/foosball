class Player < ActiveRecord::Base
  def total_games
    won + lost
  end
  
  def total_team_games
    team_won + team_lost
  end

  def self.rated_players
    player_blacklist = %w( boros fledsbo trondoiv ism )
    Player.find(:all, :order => "rating DESC").delete_if {|player| (player.total_games) < 10 }.delete_if {|player| player_blacklist.include?(player.name) }
  end
end
