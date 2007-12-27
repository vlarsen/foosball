class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.column "name", :string, :limit => 50, :null => false
      t.column "won", :integer, :default => 0
      t.column "lost", :integer, :default => 0
      t.column "rating", :float, :default => 1500.0
      t.column "team_won", :integer, :default => 0
      t.column "team_lost", :integer, :default => 0
      t.column "team_rating", :float, :default => 1500.0
    end
  end

  def self.down
    drop_table :players
  end
end
