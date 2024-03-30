class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]
  validates :password, length: { maximum: 10 }
  validates :name, presence: true # 名前がないと登録できない

    has_many :novels
    has_many :favorites
    has_many :comments, dependent: :destroy

  def self.find_for_database_authentication(warden_conditions)
    find_by(name: warden_conditions[:name])
  end

  def active_for_authentication?
    super && is_active # ユーザーがログインするためには、is_activeがtrueを返すことも必要
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64(6) # 最大6文字で生成
      customer.name = "ゲスト"
    end
  end

end
