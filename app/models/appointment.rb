class Appointment < ApplicationRecord

  belongs_to :customer

  has_one :buy_request, dependent: :destroy
  has_one :sell_request, dependent: :destroy

  validates :name, :email, presence: true

  # 電話番号(ハイフンなし10桁or11桁)
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  # 郵便番号（ハイフンなし7桁）
  validates :post_code, format: { with: /\A\d{7}\z/ }

  # 予約の種類
  enum category: {buy: 0, sell: 1, buy_and_sell: 2}

  # ゲスト予約の検索機能
  def self.search(id, email)
    return if id.blank?
    return if email.blank?
    self.where(id: id, email: email)
  end

end
