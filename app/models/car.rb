class Car < ApplicationRecord

  has_many_attached :images
  
  has_many :car_genres
  has_many :genres, through: :car_genres
  
  validates :name,
            :color,
            :passenger_amount,
            :year,
            :chassis_code,
            :mileage,
            :shaken_period,
            :grade,
            :engine_capacity,
            :transmission,
            :fuel,
  presence: true
  
  validates :name, uniqueness: true
  validates :price, :passenger_amount, numericality: {greater_than_or_equal_to: 0}
  
  # 画像呼び出しメソッド
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # 余白無しオプション
    image.variant(resize_to_fill: [width, height]).processed
  end

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  
  # 車検期間
  enum shaken_period: {no_shaken: 0, six_months: 1, one_year: 2, two_years: 3}
  # ミッションの種類
  enum transmission: {automatic: 0, four_mt: 1, five_mt: 2, six_mt: 3, other_t: 3}
  # 使用燃料の種類
  enum fuel: {gasoline: 0, diesel: 1, electric: 2}

end
