module GamesHelper
  def rating_change(change)
    if change >= 0
      "<span class='positive'>&#9650;&nbsp;#{change.round}</span>"
    else
      "<span class='negative'>&#9660;&nbsp;#{change.round}</span>"
    end
  end
end
