class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime :played_at
      t.string :red, :limit => 50
      t.integer :redscore
      t.string :blue, :limit => 50
      t.integer :bluescore
      t.float :red_rating_diff, :default => 0.0
      t.float :blue_rating_diff, :default => 0.0
    end

    create_table :players do |t|
      t.string :name, :limit => 50, :default => "", :null => false
      t.integer :won, :default => 0
      t.integer :lost, :default => 0
      t.float :rating, :default => 1500.0
      t.integer :team_won, :default => 0
      t.integer :team_lost, :default => 0
      t.float :team_rating, :default => 1500.0
    end

    create_table :team_games do |t|
      t.datetime :played_at
      t.string :red1, :limit => 50
      t.string :red2, :limit => 50
      t.integer :redscore
      t.string :blue1, :limit => 50
      t.string :blue2, :limit => 50
      t.integer :bluescore
      t.float :red_rating_diff, :default => 0.0
      t.float :blue_rating_diff, :default => 0.0
    end
  end

  def self.down
    drop_table :games
    drop_table :players
    drop_table :team_games
  end
end
