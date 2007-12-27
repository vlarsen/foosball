module MatrixHelper
  def rating_change(change)
    if change >= 0
      "<span class='positive'>&#9650;#{change.round}</span>"
    else
      "<span class='negative'>&#9660;#{change.round}</span>"
    end
  end
end
