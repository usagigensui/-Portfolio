module ApplicationHelper
  # URIライブラリの呼び出し
  require 'uri'

  # 投稿テキストのリンクやメルアドをリンク化
  def user_text(text)
    return if text.blank?

    email2a(url2a(nl2br(sanitize(text).to_s)))
  end

  # 投稿テキストの改行を反映
  def nl2br(text)
    text.gsub(/\R/) { tag.br }
    # text.gsub(/\R/) { %(<br>) }
  end

  # 投稿テキストのURLをハイパーリンクに変更
  def url2a(text)
    text.gsub(URI::DEFAULT_PARSER.make_regexp(%w[http https])) do
      tag.a Regexp.last_match(0), href: Regexp.last_match(0), target: '_blank'
      # %(<a href="#{Regexp.last_match(0)}" target="_blank">#{Regexp.last_match(0)}</a>)
    end
  end

  # 投稿テキストのメールアドレスをリンクに変更
  def email2a(text)
    text.gsub(/[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i) do
      tag.a Regexp.last_match(0), href: "mailto:#{Regexp.last_match(0)}"
      # %(<a href="mailto:#{Regexp.last_match(0)}">#{Regexp.last_match(0)}</a>)
    end
  end

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
