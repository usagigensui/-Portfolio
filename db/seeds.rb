# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理人プロフィール
User.create!(
  :id => 1,
  :email => ENV['MASTER_EMAIL'],
  :password => ENV['MASTER_PASSWORD']
)

Profile.create!(
  :id => 1,
  :user_id => 1,
  :code => "master",
  :name => "sumiyoshi",
  :introduction => "MinePageを作っているひとです。\r\今後も改良していく予定です。",
  :image => File.open("./app/assets/images/yuru_neko.png"),
  :status => 0
)

Color.create!(
  :id => 1,
  :profile_id => 1,
  :text => 2,
  :background => 4,
  :accent => 4
)

Link.create!(
  :id => 1,
  :profile_id => 1,
  :url => "https://github.com/usagigensui",
  :category => 6
)

Comment.create!(
  :id => 1,
  :profile_id => 1,
  :title => "Like♥",
  :text => "読書・お絵描き\r\まったりコーヒータイム☕"
)

Comment.create!(
  :id => 2,
  :profile_id => 1,
  :title => "Special thanks",
  :text => "アイコンはガーリー素材(https://girlysozai.com)さまよりお借りしています。"
)

# ゲストユーザー
User.create!(
  :id => 2,
  :email => "guest@example.com",
  :password => "123456789"
)

# ゲストユーザー：プロフィール１
Profile.create!(
  :id => 2,
  :user_id => 2,
  :code => "guest",
  :name => "ゲストさま",
  :introduction => "MinePageへようこそ！\r\ご自由にお過ごしください。",
  :status => 0
)

Color.create!(
  :id => 2,
  :profile_id => 2,
  :text => 0,
  :background => 0,
  :accent => 0
)

Link.create!(
  :id => 2,
  :profile_id => 2,
  :url => "https://twitter.com/?lang=ja",
  :category => 1
)

Link.create!(
  :id => 3,
  :profile_id => 2,
  :url => "https://ja-jp.facebook.com/",
  :category => 3
)

Comment.create!(
  :id => 3,
  :profile_id => 2,
  :title => "ここはプロフィールコメント欄です。",
  :text => "お好きなコメントを投稿することができます。\r\この欄はユーザーさまに自由に使っていただくため、あえて使用用途を定めていません。"
)

Comment.create!(
  :id => 4,
  :profile_id => 2,
  :title => "リンクの設置も可能です。",
  :text => "URLを入力すると、\r\https://www.google.com/?hl=ja\r\ハイパーリンクが設置されます。"
)

Post.create!(
  :id => 1,
  :profile_id => 2,
  :text => "ここはタイムラインです。\r\投稿日時が右下に表示され、最新投稿が一番上に並ぶのが特徴です。\r\何かひとこと呟いたり、お知らせに使うこともできます。"
)

Schedule.create!(
  :id => 1,
  :profile_id => 2,
  :title => "ここはカレンダーです。ちょっとした予定が入力できます。詳細はこちらをクリック⇒",
  :body => "入力した予定は右のカレンダーに反映されます。\r\お知らせや、イベント予定を共有するのにもいいかもしれません。\r\終了した予定は上の時計マークから確認できます。",
  :start_date => "2025-01-01",
  :end_date => "2025-01-01"
)

Schedule.create!(
  :id => 2,
  :profile_id => 2,
  :title => "終了した予定はここに表示されます。",
  :body => "終了した予定は削除のみ可能です。",
  :start_date => "2021-01-01",
  :end_date => "2021-01-01"
)

Inquiry.create!(
  :id => 1,
  :profile_id => 2,
  :sender => "閲覧者",
  :email => "customer@example.com",
  :title => "フォームメール機能です。詳細はこちらをクリック⇒",
  :message => "プロフィールページのメールフォームから送信されたメールがここに表示されます。\r\プロフィールオーナーへの問い合わせメール等が想定されます。\r\ゲストユーザーのアドレスはダミーのため機能しませんが、メールフォームからメールを送信すると、プロフィールオーナーの登録アドレスへ実際にメールが送信されます。"
)

# ゲストユーザー：プロフィール２
Profile.create!(
  :id => 3,
  :user_id => 2,
  :code => "guest2",
  :name => "ゲスト２さま",
  :introduction => "右下のパレットアイコンはカラーテーマの変更、手紙アイコンからフォームメールの確認ができます。",
  :status => 1
)

Color.create!(
  :id => 3,
  :profile_id => 3,
  :text => 1,
  :background => 1,
  :accent => 2
)

Link.create!(
  :id => 4,
  :profile_id => 3,
  :url => "https://twitter.com/?lang=ja",
  :category => 1
)

Link.create!(
  :id => 5,
  :profile_id => 3,
  :url => "https://www.instagram.com/?hl=ja",
  :category => 2
)

Comment.create!(
  :id => 5,
  :profile_id => 3,
  :title => "ここはプロフィールコメント欄です。",
  :text => "お好きなコメントを投稿することができます。\r\この欄はユーザーさまに自由に使っていただくため、あえて使用用途を定めていません。"
)

Comment.create!(
  :id => 6,
  :profile_id => 3,
  :title => "リンクの設置も可能です。",
  :text => "URLを入力すると、\r\https://www.google.com/?hl=ja\r\ハイパーリンクが設置されます。"
)

Post.create!(
  :id => 2,
  :profile_id => 3,
  :text => "ここはタイムラインです。\r\投稿日時が右下に表示され、最新投稿が一番上に並ぶのが特徴です。\r\何かひとこと呟いたり、お知らせに使うこともできます。"
)

Schedule.create!(
  :id => 3,
  :profile_id => 3,
  :title => "ここはカレンダーです。ちょっとした予定が入力できます。詳細はこちらをクリック⇒",
  :body => "入力した予定は右のカレンダーに反映されます。\r\お知らせや、イベント予定を共有するのにもいいかもしれません。\r\終了した予定は上の時計マークから確認できます。",
  :start_date => "2025-01-01",
  :end_date => "2025-01-01"
)

Schedule.create!(
  :id => 4,
  :profile_id => 3,
  :title => "終了した予定はここに表示されます。",
  :body => "終了した予定は削除のみ可能です。",
  :start_date => "2021-01-01",
  :end_date => "2021-01-01"
)

Inquiry.create!(
  :id => 2,
  :profile_id => 3,
  :sender => "閲覧者",
  :email => "customer@example.com",
  :title => "フォームメール機能です。詳細はこちらをクリック⇒",
  :message => "プロフィールページのメールフォームから送信されたメールがここに表示されます。\r\プロフィールオーナーへの問い合わせメール等が想定されます。\r\ゲストユーザーのアドレスはダミーのため機能しませんが、メールフォームからメールを送信すると、プロフィールオーナーの登録アドレスへ実際にメールが送信されます。"
)