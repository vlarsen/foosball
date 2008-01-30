class StatisticsController < ApplicationController

  layout "games"

  def index
    @start_date = Date.new(2008, 01, 01)
    @weeks =
      Game.find(:all,
                :select => 'week(played_at) as week, count(*) as count',
                :conditions => ["played_at >= ?", @start_date],
                :group => 'week(played_at)')
    @weekdays =
      Game.find(:all,
                :select => 'weekday(played_at) as weekday, count(*) as count',
                :conditions => ["played_at >= ?", @start_date],
                :group => 'weekday(played_at)')
    @hours =
      Game.find(:all,
                :select => 'hour(played_at) as hour, count(*) as count',
                :conditions => ["played_at >= ?", @start_date],
                :group => 'hour(played_at)')
    red_games =
        Game.find(:all,
                  :select => 'count(*) as count',
                  :conditions => ["redscore > bluescore and played_at >= ?", @start_date])
     @red_victories = red_games[0].count.to_i
     blue_games =
       Game.find(:all,
                 :select => 'count(*) as count',
                 :conditions => ["redscore < bluescore and played_at >= ?", @start_date])
     @blue_victories = blue_games[0].count.to_i
  end
end
