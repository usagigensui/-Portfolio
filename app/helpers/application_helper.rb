module ApplicationHelper
  # アイコンの選択
  def icon(category)
    case category
    when "Homepage"
      "fas fa-home"
    when "Twitter"
      "fab fa-twitter"
    when "Instagram"
      "fab fa-instagram"
    when "Facebook"
      "fab fa-facebook-f"
    when "YouTube"
      "fab fa-youtube"
    when "TikTok"
      "fab fa-tiktok"
    when "Favorite"
      "fas fa-heart"
    when "Other"
      "fas fa-star"
    end
  end
end
