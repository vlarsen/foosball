class TeamGame < ActiveRecord::Base
  validates_presence_of :red1, :red2, :blue1, :blue2
  validates_numericality_of :redscore, :bluescore, :only_integers => true
  validates_format_of :red1, :red2, :blue1, :blue2,
                      :with => /^\w+$/,
                      :message => "must be one word, i.e. username"
  validates_inclusion_of :redscore, :bluescore,
                         :in => 0..10,
                         :message => "should be between 0 and 10"

  def subtract_from_players
    # Find players, assuming players exists
    red1_player = Player.find_by_name(red1)
    red2_player = Player.find_by_name(red2)
    blue1_player = Player.find_by_name(blue1)
    blue2_player = Player.find_by_name(blue2)

    # Substract rating effect from players
    red1_player.team_rating -= red_rating_diff
    red2_player.team_rating -= red_rating_diff
    blue1_player.team_rating -= blue_rating_diff
    blue2_player.team_rating -= blue_rating_diff
    # Update win/loss statistics on players
    if redscore > bluescore
      red1_player.team_won -= 1
      red2_player.team_won -= 1
      blue1_player.team_lost -= 1
      blue2_player.team_lost -= 1
    else
      red1_player.team_lost -= 1
      red2_player.team_lost -= 1
      blue1_player.team_won -= 1
      blue2_player.team_won -= 1
    end
    # save players
    red1_player.save
    red2_player.save
    blue1_player.save
    blue2_player.save
    
    self.red_rating_diff = 0.0
    self.blue_rating_diff = 0.0
    self.save
    
  end
  
  def add_to_players
    # Find or create players
    red1_player = Player.find_by_name(red1) || Player.new(:name => red1)
    red2_player = Player.find_by_name(red2) || Player.new(:name => red2)
    blue1_player = Player.find_by_name(blue1) || Player.new(:name => blue1)
    blue2_player = Player.find_by_name(blue2) || Player.new(:name => blue2)

    # Update the rating of the players
    red_diff =  RatingHelper.get_team_rating_diff(red1_player.team_rating,  red2_player.team_rating,  redscore,
                                                  blue1_player.team_rating, blue2_player.team_rating, bluescore)
    blue_diff = RatingHelper.get_team_rating_diff(blue1_player.team_rating, blue2_player.team_rating, bluescore,
                                                  red1_player.team_rating,  red2_player.team_rating,  redscore)
    red1_player.team_rating += red_diff
    red2_player.team_rating += red_diff
    blue1_player.team_rating += blue_diff
    blue2_player.team_rating += blue_diff

    # Update win/loss statistics of the players
    if (redscore > bluescore)
      # red won
      red1_player.team_won += 1
      red2_player.team_won += 1
      blue1_player.team_lost += 1
      blue2_player.team_lost += 1
    else
      # blue won
      red1_player.team_lost += 1
      red2_player.team_lost += 1
      blue1_player.team_won += 1
      blue2_player.team_won += 1
    end

    red1_player.save
    red2_player.save
    blue1_player.save
    blue2_player.save
    
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
