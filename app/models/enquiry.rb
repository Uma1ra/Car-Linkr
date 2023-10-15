class Enquiry < ApplicationRecord

  belongs_to :customer, optional: true

  validates :title, :detail, presence: true

  # emailが空なら、phoneを必須にする + 電話番号(ハイフンなし10桁or11桁)/
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, unless: :email?

  # phoneが空なら、emailを必須にする
  validates :email, presence: true, unless: :phone_number?


end
