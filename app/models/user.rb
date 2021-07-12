class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :profiles, dependent: :destroy

  # バリデーション・パスワードは半角英数字のみ
  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/  }

  # 有効ユーザーかどうかの検証
  def active_for_authentication?
    super && (self.is_valid == true)
  end
end
