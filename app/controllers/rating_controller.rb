class RatingController < ApplicationController

  def singles
    @max_disp_history = 10
    @ratings = Hash.new { |h, k| h[k] = Player.new(k) }
    @rating_blacklist = %w(boros fledsbo trondoiv ism )
    1.times do
      clear_win_loss_stats
      calculate_singles_ratings
    end
    @ratings.delete_if {|name, player| (player.won + player.lost) < 10 }
    @ratings.delete_if {|name, player| @rating_blacklist.include?(name) }
    create_sorted_ratinglist
    
    render(:layout => "games", :template => "rating/list")
  end

  def doubles
    @max_disp_history = 10
    @ratings = Hash.new { |h, k| h[k] = OldPlayer.new(k) }
    calculate_doubles_ratings
    create_sorted_ratinglist
    render(:layout => "team_games", :template => "rating/list")
  end

  def clear_win_loss_stats
    @ratings.keys.each do |key|
      @ratings[key].clear_win_loss_stats
    end
  end

  def calculate_doubles_ratings
    TeamGame.find(:all, :order => "played_at").each do |thegame|
      if thegame.redscore > thegame.bluescore
        winner1 = thegame.red1
        winner2 = thegame.red2
        winner_score = thegame.redscore
        looser1 = thegame.blue1
        looser2 = thegame.blue2
        looser_score = thegame.bluescore
      else
        winner1 = thegame.blue1
        winner2 = thegame.blue2
        winner_score = thegame.bluescore
        looser1 = thegame.red1
        looser2 = thegame.red2
        looser_score = thegame.redscore
      end

      rating_winner1 = @ratings[winner1].rating
      rating_winner2 = @ratings[winner2].rating
      rating_looser1 = @ratings[looser1].rating
      rating_looser2 = @ratings[looser2].rating

      rating_winner = (rating_winner1 + rating_winner2) / 2
      rating_looser = (rating_looser1 + rating_looser2) / 2

      expected_result_winner = RatingHelper.get_expected(rating_winner, rating_looser)
      expected_result_looser = 1.0 - expected_result_winner
      actual_result_winner = RatingHelper.get_actual_result(winner_score, looser_score)
      actual_result_looser = 1.0 - actual_result_winner

      k_value_winner = RatingHelper.get_k_value(rating_winner, rating_looser)
      k_value_looser = RatingHelper.get_k_value(rating_looser, rating_winner)

      @ratings[winner1].rating += k_value_winner * (actual_result_winner - expected_result_winner)
      @ratings[winner1].won += 1
      @ratings[winner2].rating += k_value_winner * (actual_result_winner - expected_result_winner)
      @ratings[winner2].won += 1
      @ratings[looser1].rating += k_value_looser * (actual_result_looser - expected_result_looser)
      @ratings[looser1].lost += 1
      @ratings[looser2].rating += k_value_looser * (actual_result_looser - expected_result_looser)
      @ratings[looser2].lost += 1
    end
  end

  def create_sorted_ratinglist
    @ratinglist = @ratings.values
    @ratinglist.sort! { |x,y| y.rating <=> x.rating }
  end
  
end
