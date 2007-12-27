class PopulatePlayersFromGames < ActiveRecord::Migration
  def self.up
    puts "Populating players table from #{Game.count} singles games"
    progress = 0
    Game.find(:all, :order => "played_at").each do |g|
      progress += 1
      if (progress % 100) == 0
        puts progress
      end
      
      g.add_to_players
    end
    
    puts "Populating players table from #{TeamGame.count} team games"
    progress = 0
    TeamGame.find(:all, :order => "played_at").each do |g|
      progress += 1
      if (progress % 10) == 0
        puts progress
      end
      
      g.add_to_players
    end
    
  end

  def self.down
    Player.delete_all
  end
end
