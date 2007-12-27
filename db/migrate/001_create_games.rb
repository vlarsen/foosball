class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.column "played_at", :datetime
      t.column "red", :string, :limit => 50
      t.column "redscore", :integer
      t.column "blue", :string, :limit => 50
      t.column "bluescore", :integer
    end
  end

  def self.down
    drop_table :games
  end
end
