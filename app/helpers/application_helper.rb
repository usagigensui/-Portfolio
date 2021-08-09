module ApplicationHelper
  # プロフィールオーナーのログイン確認
  def current_user_signed_in?(profile)
    user_signed_in? && current_user.id == profile.user_id
  end

  # タブメニューのアクティブ確認
  def active_if(path)
    path == controller_path ? 'active' : ''
  end

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
