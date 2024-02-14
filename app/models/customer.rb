class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, length: { maximum: 10 }

    has_many :novels
    has_many :favorites
    has_many :comments, dependent: :destroy


  def self.guest
    find_or_create_by!(email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64(6) # 最大6文字で生成
      customer.name = "ゲスト"
    end
  end

end
