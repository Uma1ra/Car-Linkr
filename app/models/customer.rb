class Customer < ApplicationRecord
  
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
  
  def require_validation?
    return true if self.guest == false || self.guest == 0
      false
  end

  # ゲストユーザーを作成する
  def self.guest
    random_pass = SecureRandom.base36
    random_email = SecureRandom.base58 + "@email.com"
    
    create!(password: random_pass,
            email: random_email,
            guest: true)
  end
  
end
