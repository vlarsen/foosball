# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091224152231) do

  create_table "games", :force => true do |t|
    t.datetime "played_at"
    t.string   "red",              :limit => 50
    t.integer  "redscore"
    t.string   "blue",             :limit => 50
    t.integer  "bluescore"
    t.float    "red_rating_diff",                :default => 0.0
    t.float    "blue_rating_diff",               :default => 0.0
  end

  create_table "players", :force => true do |t|
    t.string  "name",        :limit => 50, :default => "",     :null => false
    t.integer "won",                       :default => 0
    t.integer "lost",                      :default => 0
    t.float   "rating",                    :default => 1500.0
    t.integer "team_won",                  :default => 0
    t.integer "team_lost",                 :default => 0
    t.float   "team_rating",               :default => 1500.0
  end

  create_table "team_games", :force => true do |t|
    t.datetime "played_at"
    t.string   "red1",             :limit => 50
    t.string   "red2",             :limit => 50
    t.integer  "redscore"
    t.string   "blue1",            :limit => 50
    t.string   "blue2",            :limit => 50
    t.integer  "bluescore"
    t.float    "red_rating_diff",                :default => 0.0
    t.float    "blue_rating_diff",               :default => 0.0
  end

end
