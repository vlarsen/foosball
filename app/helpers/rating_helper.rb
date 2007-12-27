module RatingHelper

  def RatingHelper.get_expected(rating1, rating2)
    1.0 / (1.0 + (10 ** ((rating2 - rating1)/400.0)) )
  end

  def RatingHelper.get_k_value(rating1, rating2)
    64
    # rating1 > 2000 ? 32 : 64
  end

  def RatingHelper.get_actual_result(score_my, score_opp)
    if score_my > score_opp
      1.0 - score_opp.to_f / 20
    else
      score_my.to_f / 20
    end
  end

  def RatingHelper.get_rating_diff(my_rating, my_score, opp_rating, opp_score)
    expected = RatingHelper.get_expected(my_rating, opp_rating)
    actual = RatingHelper.get_actual_result(my_score, opp_score)
    k = RatingHelper.get_k_value(my_rating, opp_rating)
    diff = k * (actual - expected)
  end

  def RatingHelper.get_team_rating_diff(my1_rating, my2_rating, my_score, opp1_rating, opp2_rating, opp_score)
    my_rating = (my1_rating + my2_rating) / 2
    opp_rating = (opp1_rating + opp2_rating) / 2
    expected = RatingHelper.get_expected(my_rating, opp_rating)
    actual = RatingHelper.get_actual_result(my_score, opp_score)
    k = RatingHelper.get_k_value(my_rating, opp_rating)
    diff = k * (actual - expected)
  end

  def RatingHelper.get_expected_scores_from_ratings(my_rating, opp_rating)
    expected = get_expected(my_rating, opp_rating)

    min_diff = 1.0
    act_exp_diff = 1.0
    closest_score = "unknown"

    0.upto(9) do |score_opp|
      act_exp_diff = (expected - get_actual_result(10, score_opp)).abs
      if act_exp_diff < min_diff
        min_diff = act_exp_diff
        closest_score = "10-#{score_opp}"
      end
    end
    0.upto(9) do |score_my|
      act_exp_diff = (expected - get_actual_result(score_my, 10)).abs
      if act_exp_diff < min_diff
        min_diff = act_exp_diff
        closest_score = "#{score_my}-10"
      end
    end

    closest_score
  end

end
