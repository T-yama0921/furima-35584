class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname
    validates :birth_date
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "is invalid. Input full-width characters."} do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters."}do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, presence: true, message: 'には英字と数字の両方を含めて半角で設定してください' 

end
