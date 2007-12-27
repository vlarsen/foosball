class CreateTeamGames < ActiveRecord::Migration
  def self.up
    create_table :team_games do |t|
      t.column "played_at", :datetime
      t.column "red1", :string, :limit => 50
      t.column "red2", :string, :limit => 50
      t.column "redscore", :integer
      t.column "blue1", :string, :limit => 50
      t.column "blue2", :string, :limit => 50
      t.column "bluescore", :integer
    end
  end

  def self.down
    drop_table :team_games
  end
end
