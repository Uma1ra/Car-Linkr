class Customer < ApplicationRecord
  before_create :set_customer_id
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :last_name,
            :first_name,
            :last_name_kana,
            :first_name_kana,
  presence: true, if: :require_validation?
  
  # 電話番号(ハイフンなし10桁or11桁)
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, if: :require_validation?
  
  # 郵便番号（ハイフンなし7桁）
  validates :post_code, format: { with: /\A\d{7}\z/ }, if: :require_validation?
  
  
  
  
  def full_name
     self.last_name + " " + self.first_name
  end
  
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end
  
  private
  
  # def require_validation?
  #   return true if self.is_guest == false || self.is_guest == 0
  #     false
  # end
  
  # # ランダムなユーザーIDを生成
  # def set_customer_id
  #   while self.id.blank? || Customer.find_by(id: self.id).present? do
  #     self.id = SecureRandom.base58
  #   end
  # end

  # # ゲストユーザーを作成する
  # def self.guest_login
  #   random_pass = SecureRandom.base36
  #   random_email = SecureRandom.base58 + "@email.com"
    
  #   create!(password: random_pass,
  #           email: random_email,
  #           is_guest: true)
  # end
  
end
