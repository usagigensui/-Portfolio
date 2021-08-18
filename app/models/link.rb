class Link < ApplicationRecord
  belongs_to :profile

  # プロフィールID、URL、カテゴリーは空白禁止
  with_options presence: true do
    validates :profile_id
    validates :url
    validates :category
  end

  # カテゴリーはenum管理
  enum category: { "Homepage": 0, "Twitter": 1, "Instagram": 2, "Facebook": 3, "YouTube": 4, "TikTok": 5,
                   "Github": 6, "Favorite": 7, "Other": 8 }
end
