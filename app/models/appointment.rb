class Appointment < ApplicationRecord

  belongs_to :customer

  has_many :buy_requests, dependent: :destroy
  has_many :sell_requests, dependent: :destroy

  validates :name, :email, presence: true

  # 電話番号(ハイフンなし10桁or11桁)
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  # 郵便番号（ハイフンなし7桁）
  validates :post_code, format: { with: /\A\d{7}\z/ }

  # 予約の種類
  enum category: {buy: 0, sell: 1, buy_and_sell: 2}

end
