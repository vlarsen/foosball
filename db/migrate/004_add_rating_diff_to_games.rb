class AddRatingDiffToGames < ActiveRecord::Migration
  def self.up
    add_column "games", "red_rating_diff", :float, :default => 0.0
    add_column "games", "blue_rating_diff", :float, :default => 0.0
    add_column "team_games", "red_rating_diff", :float, :default => 0.0
    add_column "team_games", "blue_rating_diff", :float, :default => 0.0
  end

  def self.down
    remove_column "games", "red_rating_diff"
    remove_column "games", "blue_rating_diff"
    remove_column "team_games", "red_rating_diff"
    remove_column "team_games", "blue_rating_diff"
  end
end
