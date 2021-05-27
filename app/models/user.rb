class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください', allow_blank: true
  with_options presence: true do
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角文字を使用してください', allow_blank: true } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶ]+\z/, message: 'には全角カナ文字を使用してください', allow_blank: true } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :user_birth_date
  end
  has_many :items
  has_many :purchase_records
end
