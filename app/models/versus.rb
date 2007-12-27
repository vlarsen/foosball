=begin
Accumulates statistics of a particular player pair.
=end
class Versus
  attr_reader :wins, :losses, :red, :blue
  attr_reader :scores
  attr_reader :rating_gain, :rating_loss

  # The the total number of games played in this pairing.
  def total
    wins + losses
  end

  def initialize(player, opponent)
    @player = player
    @opponent = opponent
    @wins = 0
    @losses = 0
    @rating_gain = 0
    @rating_loss = 0
    @red = 0
    @blue = 0
    @scores = []
  end

  # Record the change in the versus state based on the result of a match.
  def process_result(game)
    if game.red == @player
      as_red
      my_score = game.redscore
      opp_score = game.bluescore
      my_rating_diff = game.red_rating_diff
      opp_rating_diff = game.blue_rating_diff
    else
      as_blue
      my_score = game.bluescore
      opp_score = game.redscore
      my_rating_diff = game.blue_rating_diff
      opp_rating_diff = game.red_rating_diff
    end
    if my_rating_diff > 0
      @rating_gain += my_rating_diff
    else
      @rating_loss += my_rating_diff
    end
    @scores << my_score - opp_score
    if my_score > opp_score
      victory
    else
      defeat
    end
  end

  private
  # Count a victory for the player.
  def victory
    @wins += 1
  end

  # Count a defeat for the player.
  def defeat
    @losses += 1
  end

  # Count that the player was red.
  def as_red
    @red += 1
  end

  # Count that the player was blue.
  def as_blue
    @blue += 1
  end
      
end

