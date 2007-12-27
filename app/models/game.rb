class Game < ActiveRecord::Base
  validates_presence_of :red, :blue
  validates_numericality_of :redscore, :bluescore, :only_integers => true
  validates_format_of :red, :blue,
                      :with => /^\w+$/,
                      :message => "must be one word, i.e. username"
  validates_inclusion_of :redscore, :bluescore,
                         :in => 0..10,
                         :message => "should be between 0 and 10"

  def self.rated_games
#    Game.find(:all,
#         :conditions => ["played_at >= ?", 30.days.ago],
#         :order => "played_at")
    Game.find(:all, :order => "played_at")
  end

  # Removes the ranking from this game from the relevant player records
  # Also resets the rating diff on the game
  # Saves self
  def subtract_from_players
    # Find players, assuming players exists
    red_player = Player.find_by_name(red)
    blue_player = Player.find_by_name(blue)
    # Substract rating effect from players
    red_player.rating -= red_rating_diff
    blue_player.rating -= blue_rating_diff
    # Update win/loss statistics on players
    if redscore > bluescore
      red_player.won -= 1
      blue_player.lost -= 1
    else
      red_player.lost -= 1
      blue_player.won -= 1
    end
    # save players
    red_player.save
    blue_player.save
    
    self.red_rating_diff = 0.0
    self.blue_rating_diff = 0.0
    self.save
  end

  # Update the relevant player records, and the rating_diff on the game
  # Saves self
  def add_to_players
    # Find or create players
    red_player = Player.find_by_name(red) || Player.new(:name => red)
    blue_player = Player.find_by_name(blue) || Player.new(:name => blue)

    # Update the rating of the players
    red_diff =  RatingHelper.get_rating_diff(red_player.rating,  redscore,
                                             blue_player.rating, bluescore)
    blue_diff = RatingHelper.get_rating_diff(blue_player.rating, bluescore,
                                             red_player.rating,  redscore)
    red_player.rating += red_diff
    blue_player.rating += blue_diff

    # Update win/loss statistics of the players
    if (redscore > bluescore)
      # red won
      red_player.won += 1
      blue_player.lost += 1
    else
      # blue won
      red_player.lost += 1
      blue_player.won += 1
    end

    red_player.save
    blue_player.save
    
    # update the rating effect on the game
    self.red_rating_diff = red_diff
    self.blue_rating_diff = blue_diff
    self.save
  end

  protected
  def validate
    if !redscore.nil? && !bluescore.nil?
      if redscore != 10 && bluescore != 10
        errors.add_to_base("One of the scores must be 10")
      end
      if redscore == 10 && bluescore == 10
        errors.add_to_base("Only one of the scores can be 10")
      end
    end
  end

end
