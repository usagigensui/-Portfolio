class Profile < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :inquiries, dependent: :destroy
  has_many :links, dependent: :destroy
  has_one :color, dependent: :destroy
  has_many :images, dependent: :destroy
  has_one :function_setting, dependent: :destroy

  # プロフィールコード、名前は空白禁止
  with_options presence: true do
    # プロフィールコードは一意で20文字以内、アクション名と被らないこと
    validates :code, uniqueness: true, length: { maximum: 20 }, format: { with: /\A[a-z0-9]+\z/ },
                     exclusion: { in: %w[new search] }
    # 名前は20文字以内
    validates :name, length: { maximum: 20 }
  end

  # 自己紹介は160文字以内
  validates :introduction, length: { maximum: 160 }

  # image_idに画像投稿機能を追加
  attachment :image

  # 公開設定をenum管理
  enum status: { "公開": 0, "非公開": 1 }

  # URLのIDをプロフィールコードに
  def to_param
    code
  end

  # ユーザー検索
  def self.search(keyword)
    where(['code like? OR name like?', "%#{keyword}%", "%#{keyword}%"]).where.not(status: :"非公開")
  end
end
