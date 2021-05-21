class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name,       format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters.", allow_blank: true }
    validates :first_name,      format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters.", allow_blank: true }
    validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters.", allow_blank: true }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters.", allow_blank: true }
    validates :birth_date
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true, message: 'には英字と数字の両方を含めて設定してください' 

end
