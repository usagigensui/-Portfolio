module ApplicationHelper
  # アイコンの選択

  NAMES = {
    'Homepage' => 'fas fa-home',
    'Twitter' => 'fab fa-twitter',
    'Instagram' => 'fab fa-instagram',
    'Facebook' => 'fab fa-facebook-f',
    'YouTube' => 'fab fa-youtube',
    'TikTok' => 'fab fa-tiktok',
    'Favorite' => 'fas fa-heart',
    'Other' => 'fas fa-star'
  }.freeze

  def icon(category)
    NAMES[category]
  end
end
